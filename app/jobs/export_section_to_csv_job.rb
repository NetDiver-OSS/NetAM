require 'csv'
class ExportSectionToCsvJob < ApplicationJob
  queue_as :default

  def perform(*args)
    database_entries = Usage.joins(:section).where(section_id: args[0]).pluck('sections.id', 'sections.name', :ip_used, :fqdn, :description, :state)
    attributes = %w{ID Section Address FQDN Description State}
    mycsv = CSV.generate(headers: true) do |csv|
      csv << attributes
      database_entries.each do |ip_usage|
        case ip_usage[4]
        when 'locked'
          ip_usage[4] = 'Reserved'
        when 'actived'
          ip_usage[4] = 'Active'
        when 'down'
          ip_usage[4] = 'Inactive'
        when 'dhcp'
          ip_usage[4] = 'DHCP'
        end
        csv << ip_usage
      end
    end
    return mycsv
  end
end
