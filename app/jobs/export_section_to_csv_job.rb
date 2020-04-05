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
    attributes = %w{section_name, ip, fqdn, description, state}
    mycsv = CSV.generate(headers: true) do |csv|
      csv << attributes
      database_entries.each do |ip_usage|
        if ip_usage[4] == 0
          ip_usage[4] = 'Reserved'
        elsif ip_usage[4] == 1
          ip_usage[4] = 'Active'
        elsif ip_usage[4] == 2
          ip_usage[4] = 'Inactive'
        elsif ip_usage[4] == 3
          ip_usage[4] = 'DHCP'
        end
        csv << ip_usage
      end
    end
    return mycsv
  end
end
