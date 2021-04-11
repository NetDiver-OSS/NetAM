# frozen_string_literal: true

class ReindexTypesense
  include Sidekiq::Worker

  def perform
    DeviceType.all.each do |devicetype|
      ::DeviceTypes::ReindexService.new(nil, devicetype).execute
    end

    Device.all.each do |device|
      ::Devices::ReindexService.new(nil, device).execute
    end

    Rackspace.all.each do |rackspace|
      ::Rackspaces::ReindexService.new(nil, rackspace).execute
    end

    Section.all.each do |section|
      ::Sections::ReindexService.new(nil, section).execute
    end

    Usage.all.each do |usage|
      ::Usages::ReindexService.new(nil, usage).execute
    end

    Vlan.all.each do |vlan|
      ::Vlans::ReindexService.new(nil, vlan).execute
    end
  end
end
