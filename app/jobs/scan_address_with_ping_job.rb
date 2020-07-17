require 'net/ping'
require 'resolv'

class ScanAddressWithPingJob < ApplicationJob
  queue_as :default

  def perform(*args)
    raise 'Job can only process 1 network at the time' if args.count > 1

    Sidekiq.logger.info "Starting address scan process: #{args[0][:ip_used]}"

    if %w[locked dhcp].include? args[0][:state]
      Sidekiq.logger.error("#{self.class.name} is not able to process locked or dhcp address")
      return
    end

    ping = Net::Ping::External.new(args[0][:ip_used].to_s).ping?

    Sidekiq.logger.info "IP #{args[0][:ip_used]} is #{ping ? 'active' : 'inactive'}"

    addr_id = Usage.where(id: args[0][:id], ip_used: args[0][:ip_used].to_s, section_id: args[0][:section_id]).first_or_create

    if ping
      addr_id.update_attributes(state: :actived)
    else
      addr_id.update_attributes(state: :down)
    end
  end
end
