require 'csv'
class ExportSectionToCsvJob < ApplicationJob
  queue_as :default

  def perform(*args)
    database_entries = Usage.joins(:section).where(section_id: args[0]).pluck('sections.id', 'sections.name', :ip_used, :fqdn, :description, :state)
    attributes = %w[ID Section Address FQDN Description State]

    CSV.generate(headers: true) do |csv|
      csv << attributes
      database_entries.each do |ip_usage|
        ip_usage[5] = case ip_usage[5]
                      when 'locked'
                        'Reserved'
                      when 'actived'
                        'Active'
                      when 'down'
                        'Inactive'
                      when 'dhcp'
                        'DHCP'
                      else
                        'Unknown'
                      end
        csv << ip_usage
      end
    end
  end
end
