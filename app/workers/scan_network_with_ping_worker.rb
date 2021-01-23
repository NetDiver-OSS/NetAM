# frozen_string_literal: true

require 'resolv'

class ScanNetworkWithPingWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker
  include StatusExpiration

  SKIPPED_STATE = %w[locked dhcp].freeze

  def perform(*args)
    raise 'Job can only process 1 network at the time' if args.count > 1

    section = {
      id: args[0][:id] || args[0]['id'],
      network: IPAddr.new(args[0][:network] || args[0]['network'])
    }

    Sidekiq.logger.info "Starting network process: #{section[:network]}"

    @section_usage = Usage.where(section_id: section[:id]).select(:ip_used, :state, :fqdn).to_a
    section_to_update = []

    Parallel.each(section[:network].to_range, in_threads: Rails.configuration.netam[:sidekiq][:parallel]) do |address|
      usage = {
        state: @section_usage.filter_map { |entry| entry.state if entry.ip_used.to_s == address.to_s },
        fqdn: @section_usage.filter_map { |entry| entry.fqdn if entry.ip_used.to_s == address.to_s }
      }

      if SKIPPED_STATE.include? usage[:state].first
        Sidekiq.logger.info "Address #{address} is not able to be process if state is locked or dhcp"
        next
      end

      scanner = { ping: NetAM::Scanner::Ping.new(address.to_s).scan! }

      current_usage = { identifier: "#{section[:id]}_#{address}", ip_used: address.to_s, section_id: section[:id] }

      if scanner[:ping]
        Sidekiq.logger.info usage[:state].count.positive? ? "Known active IP: #{address}" : "Found new active IP: #{address}"

        current_usage[:state] = :actived

        scanner[:reverse] = NetAM::Network::Dns.reverse_dns(address)

        unless scanner[:reverse].nil?
          Sidekiq.logger.info "Found PTR for IP #{address}: #{scanner[:reverse]}"
          current_usage[:fqdn] = scanner[:reverse]
        end

      elsif usage[:state].count.positive?
        Sidekiq.logger.info "Known unactive IP: #{address}"

        current_usage[:state] = :down
      end

      section_to_update << current_usage if current_usage.length > 3
    end

    # Fix error "All objects being inserted must have the same keys"
    # Need rework...
    unless section_to_update.empty?
      lite_section = section_to_update.dup.keep_if { |h| h.length == 4 }
      full_section = section_to_update.dup.keep_if { |h| h.length == 5 }

      Usage.upsert_all(lite_section, unique_by: %i[identifier]) unless lite_section.empty?
      Usage.upsert_all(full_section, unique_by: %i[identifier]) unless full_section.empty?
    end

    Notifications::SendService.call({ section: section, message: 'Scan finished !' }) if Section.find(section[:id]).settings(:notification).on_run
  end
end
