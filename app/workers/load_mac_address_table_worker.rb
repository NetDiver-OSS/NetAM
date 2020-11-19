# frozen_string_literal: true

class LoadMacAddressTableWorker
  include Sidekiq::Worker

  def perform(file_name = 'oui.txt')
    response = Faraday.get "http://standards-oui.ieee.org/oui/#{file_name}"
    raise StandardError, 'Unable to download MAC Address database file' unless response.status == 200

    Sidekiq.logger.debug("Writing downloaded content to file as temporary file #{file_name}")
    output_file = File.new(Rails.root.join("tmp/#{file_name}"), 'w')
    output_file.syswrite(response.body)
    IngestOuiDatabaseWorker.perform_async
  end
end
