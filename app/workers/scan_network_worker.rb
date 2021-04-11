# frozen_string_literal: true

require 'resolv'

class ScanNetworkWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker
  include StatusExpiration

  SKIPPED_STATE = %w[locked dhcp].freeze

  def perform(*args)
    raise 'Job can only process 1 network at the time' if args.count > 1

    section = {
      id: args[0][:id] || args[0]['id'],
      scan_type: args[0][:scan_type] || args[0]['scan_type'],
      network: IPAddr.new(args[0][:network] || args[0]['network'])
    }

    Sidekiq.logger.info "Starting network process: #{section[:network]}"

    @section_usage = Usage.where(section_id: section[:id]).select(:ip_used, :state, :fqdn).to_a

    Parallel.each(section[:network].to_range, in_threads: Rails.configuration.netam[:sidekiq][:parallel]) do |address|
      current_usage = { ip_used: address.to_s, section_id: section[:id] }
      usage = {
        state: @section_usage.filter_map { |entry| entry.state if entry.ip_used.to_s == address.to_s },
        fqdn: @section_usage.filter_map { |entry| entry.fqdn if entry.ip_used.to_s == address.to_s }
      }

      if SKIPPED_STATE.include? usage[:state].first
        Sidekiq.logger.info "Address #{address} is not able to be process if state is: #{SKIPPED_STATE.join(', ')}"
        next
      end

      scanner = {
        ping: "NetAM::Scanner::#{section[:scan_type].to_s.titleize.delete(' ')}".constantize.new(address.to_s, Section.find(section[:id]).settings(:scanner).port).scan!
      }

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

      if current_usage.length > 2
        usaged = Usage.find_or_create_by(identifier: "#{section[:id]}_#{address}")
        usaged.update!(current_usage)
        ::Usages::ReindexService.new(nil, usaged).execute
      end
    end

    send_notification(section)
  end

  private

  def send_notification(section)
    Notifications::SendService.call({ section: section, message: _('Scan finished !') }) if Section.find(section[:id]).settings(:notification).on_run
  end
end
