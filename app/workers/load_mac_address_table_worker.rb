class LoadMacAddressTableWorker
  include Sidekiq::Worker

  def perform(*args)
    # Do something
    response = Faraday.get 'http://standards-oui.ieee.org/oui/oui.txt'
    if response.status == 200
      output_file = File.new(Rails.root.join('tmp/oui.txt'), 'w')
      output_file.syswrite(response.body)
    else
      Sidekiq.logger.error('Unable to download MAC Address database file')
    end
  end
end
