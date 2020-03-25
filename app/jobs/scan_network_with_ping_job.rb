require 'net/ping'
require 'resolv'

class ScanNetworkWithPingJob < ApplicationJob
  queue_as :default

  def perform(*args)
    raise 'Job can only process 1 network at the time' if args.count > 1

    network_to_scan = IPAddr.new args[0][:network] || args[0]['network']
    section_id = args[0][:id] || args[0]['id']
    database_entries = Usage.where(section_id: section_id).map { |usage| { ip: usage.ip_used, state: usage.state, fqdn: usage.fqdn } }

    Sidekiq.logger.info "Starting network process: #{network_to_scan.to_string}"

    Parallel.each(network_to_scan.to_range, in_processes: 50, progress: "Scan network #{network_to_scan}") do |address|
      address_state = database_entries.filter_map { |entry| entry[:state] if entry[:ip].to_s == address.to_s }
      fqdn_entry = database_entries.filter_map { |entry| entry[:fqdn] if entry[:ip].to_s == address.to_s }

      next if address_state.count > 0 and [0, 3].include? address_state.first
      begin
        reverse_dns = Resolv.new.getname address.to_s
      rescue Resolv::ResolvError
        #Sidekiq.logger.warn "Unable to reverse: #{address}"
      end
      if Net::Ping::External.new(address.to_s).ping?
        if address_state.count > 0
          Sidekiq.logger.info "Known active IP: #{address}"
          addr_id = Usage.where(ip_used: address.to_s, section_id: section_id).first_or_create
          addr_id.update_attributes(
            :state => 1
          )
          unless reverse_dns.nil?
            Sidekiq.logger.info "Found PTR for known active IP: #{address}"
            addr_id.update_attributes(
              :fqdn => reverse_dns
            )
          end
        else
          Sidekiq.logger.info "Found new active IP: #{address}"
          unless reverse_dns.nil?
            Sidekiq.logger.info "Found PTR for IP #{address}: #{reverse_dns}"
            Usage.where(ip_used: address.to_s, section_id: section_id, state: 1, fqdn: reverse_dns).first_or_create
          else
            Usage.where(ip_used: address.to_s, section_id: section_id, state: 1).first_or_create
          end
        end
        Usage.where(ip_used: address.to_s, section_id: section_id).first_or_create
      else
        if address_state.count > 0
          Sidekiq.logger.info "Known unactive IP: #{address}"
          addr_id = Usage.where(ip_used: address.to_s, section_id: section_id).first_or_create
          addr_id.update_attributes(
            :state => 2
          )
        end
      end
    end

    #Usage.delete Usage.where.not(ip_used: online_addresses).where(section_id: section_id).map(&:id).to_a
  end
end
