require 'net/ping'
require 'resolv'

class ScanAddressWithPingJob < ApplicationJob
  queue_as :default

  def perform(*args)
    raise 'Job can only process 1 network at the time' if args.count > 1
    Sidekiq.logger.info "Starting address scan process: #{args[0][:ip_used].to_s}"
    unless ['locked', 'dhcp'].include? args[0][:state]
      if Net::Ping::External.new(args[0][:ip_used].to_s).ping?
        Sidekiq.logger.info "IP #{args[0][:ip_used].to_s} is active"
        addr_id = Usage.where(id: args[0][:id], ip_used: args[0][:ip_used].to_s, section_id: args[0][:section_id]).first_or_create
        addr_id.update_attributes(
          :state => :actived
        )
      else
        Sidekiq.logger.info "IP #{args[0][:ip_used].to_s} is inactive"
        addr_id = Usage.where(id: args[0][:id], ip_used: args[0][:ip_used].to_s, section_id: args[0][:section_id]).first_or_create
        addr_id.update_attributes(
          :state => :down
        )
      end
    end
  end
end
