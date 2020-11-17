# frozen_string_literal: true

require 'csv'
class ExportSectionToCsvJob < ApplicationJob
  queue_as :default

  def perform(*args)
    database_entries = Usage.joins(:section).where(section_id: args[0]).pluck('sections.id', 'sections.name', :ip_used, :fqdn, :description, :state)
    attributes = %w[id section ip hostname description state]

    CSV.generate(headers: true) do |csv|
      csv << attributes
      database_entries.each do |ip_usage|
        ip_usage[5] = case ip_usage[5]
                      when 'locked'
                        'LOCKED'
                      when 'actived'
                        'ACTIVED'
                      when 'down'
                        'DOWN'
                      when 'dhcp'
                        'DHCP'
                      else
                        'UNKNOWN'
                      end
        csv << ip_usage
      end
    end
  end
end
