require 'csv'
class ExportSectionToCsvJob < ApplicationJob
  queue_as :default

  def perform(*args)
    database_entries = Usage.where(section_id: args[0]).map { |usage| {
                                                      ip: usage.ip_used,
                                                      state: usage.state,
                                                      fqdn: usage.fqdn,
                                                      description: usage.description,
                                                      section_name: usage.section.name
                                                    }}
    #Sidekiq.logger.info "Starting network process: #{database_entries}"
    attributes = %w{section_name, ip, fqdn, description, state}
    CSV.generate(headers: true) do |csv|
      csv << attributes

      puts "-------------  CSV INSPECTION ------------------"
      puts csv.inspect

      database_entries.each do |ip_usage|
        csv << ip_usage.values
      end

      puts csv.inspect
    end
  end
end
