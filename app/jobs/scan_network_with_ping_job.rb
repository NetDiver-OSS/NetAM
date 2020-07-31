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

    section_usage = Usage.where(section_id: section[:id]).select(:ip_used, :state, :fqdn)

    Parallel.each(section[:network].to_range, in_processes: Rails.configuration.netam[:sidekiq][:parallel]) do |address|
      usage = {
        state: section_usage.filter_map { |entry| entry.state if entry.ip_used.to_s == address.to_s },
        fqdn: section_usage.filter_map { |entry| entry.fqdn if entry.ip_used.to_s == address.to_s }
      }

      if %w[locked dhcp].include? usage[:state].first
        Sidekiq.logger.error("Address #{address} is not able to be process if state is locked or dhcp")
        next
      end

      scanner = {
        ping: Net::Ping::External.new(address.to_s, nil, 1).ping?,
        reverse: Netam::Network::Dns.reverse_dns(address)
      }

      current_usage = Usage.where(ip_used: address.to_s, section_id: section[:id])

      if scanner[:ping]
        Sidekiq.logger.info usage[:state].count.positive? ? "Known active IP: #{address}" : "Found new active IP: #{address}"

        current_usage.first_or_create.update(state: :actived)

        unless scanner[:reverse].nil?
          Sidekiq.logger.info "Found PTR for IP #{address}: #{scanner[:reverse]}"
          current_usage.first_or_create.update(fqdn: scanner[:reverse])
        end

      else
        if usage[:state].count.positive?
          Sidekiq.logger.info "Known unactive IP: #{address}"

          current_usage.first_or_create.update(state: :down)
        end
      end
    end
  end
end
