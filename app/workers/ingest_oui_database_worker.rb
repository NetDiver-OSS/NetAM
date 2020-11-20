# frozen_string_literal: true

class IngestOuiDatabaseWorker
  include Sidekiq::Worker

  def perform
    MacAddress.transaction do
      MacAddress.delete_all

      File.open(Rails.root.join('tmp/oui.txt')).each_line do |line|
        next unless line.match?('\(hex\)')

        mac_address, mac_vendor = line.split('(hex)')
        MacAddress.create(mac: mac_address.tr('-', ':').strip, vendor: mac_vendor.strip)
      end
    end
  end
end
