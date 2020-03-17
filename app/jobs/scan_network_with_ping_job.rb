require 'net/ping'

class ScanNetworkWithPingJob < ApplicationJob
  queue_as :default

  def perform(*args)
    raise 'Job can only process 1 network at the time' if args.count > 1

    network_to_scan = IPAddr.new args[0].network

    scan = []
    network_to_scan.to_range.each_with_index do |address, index|
      scan[index] = Thread.new {
        check = Net::Ping::External.new address.to_s

        # database_entry = Usage.where(ip_used: address, section_id: args[0].id)
        if check.ping?
          Sidekiq.logger.info "Found Active IP: #{address}"

          Usage.new(ip_used: address, section_id: args[0].id).save # unless database_entry.empty?
          #else
          #Usage.delete_by(ip_used: address, section_id: args[0].id) unless database_entry.empty?
        end
      }
    end

    scan.each(&:join)
  end
end
