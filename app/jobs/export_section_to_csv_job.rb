require 'csv'
class ExportSectionToCsvJob < ApplicationJob
  queue_as :default

  def perform(*args)
    database_entries = Usage.where(section_id: args[0]).map { |usage| [
                                                      usage.section.name,
                                                      usage.ip_used,
                                                      usage.fqdn,
                                                      usage.description,
                                                      usage.state ]}
    attributes = %w{Section Address FQDN Description State}
    mycsv = CSV.generate(headers: true) do |csv|
      csv << attributes
      database_entries.each do |ip_usage|
        case ip_usage[4]
        when 0
          ip_usage[4] = 'Reserved'
        when 1
          ip_usage[4] = 'Active'
        when 2
          ip_usage[4] = 'Inactive'
        when 3
          ip_usage[4] = 'DHCP'
        end
        csv << ip_usage
      end
    end
    return mycsv
  end
end
