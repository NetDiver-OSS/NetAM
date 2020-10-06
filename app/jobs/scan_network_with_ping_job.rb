require 'net/ping'
require 'resolv'

class ScanNetworkWithPingJob < ApplicationJob
  queue_as :default

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

      if %w[locked dhcp].include? usage[:state].first
        Sidekiq.logger.info "Address #{address} is not able to be process if state is locked or dhcp"
        next
      end

      scanner = { ping: Net::Ping::External.new(address.to_s, nil, 1).ping? }

      current_usage = { identifier: "#{section[:id]}_#{address}", ip_used: address.to_s, section_id: section[:id] }

      if scanner[:ping]
        Sidekiq.logger.info usage[:state].count.positive? ? "Known active IP: #{address}" : "Found new active IP: #{address}"

        current_usage.merge!({ state: :actived })

        scanner.merge!({ reverse: NetAM::Network::Dns.reverse_dns(address) })

        unless scanner[:reverse].nil?
          Sidekiq.logger.info "Found PTR for IP #{address}: #{scanner[:reverse]}"
          current_usage.merge!({ fqdn: scanner[:reverse] })
        end

      else
        if usage[:state].count.positive?
          Sidekiq.logger.info "Known unactive IP: #{address}"

          current_usage.merge!({ state: :down })
        end
      end

      section_to_update << current_usage if current_usage.length > 3
    end

    Usage.upsert_all(section_to_update, unique_by: %i[identifier]) unless section_to_update.empty?
  end
end
