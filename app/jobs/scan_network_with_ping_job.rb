require 'net/ping'

class ScanNetworkWithPingJob < ApplicationJob
  queue_as :default

  def perform(*args)
    raise 'Job can only process 1 network at the time' if args.count > 1

    network_to_scan = IPAddr.new args[0].network
    section_id = args[0].id
    database_entries = Usage.where(section_id: section_id).map(&:ip_used).to_a
    online_addresses = []

    Sidekiq.logger.info "Starting network process: #{network_to_scan.to_string}"

    scan = []
    network_to_scan.to_range.each_with_index do |address, index|
      scan[index] = Thread.new {
        check = Net::Ping::External.new address.to_s

        if check.ping?
          Sidekiq.logger.info "Found Active IP: #{address}"

          online_addresses << address.to_s
        end
      }
    end

    scan.each(&:join)

    Sidekiq.logger.info "Database update for Section: #{section_id}"

    Usage.delete Usage.where.not(ip_used: online_addresses).where(section_id: section_id).map(&:id).to_a

    Usage.create online_addresses.map { |address|
      {ip_used: address, section_id: section_id} unless database_entries.include?(address)
    }.to_a
  end
end
