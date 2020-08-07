Sidekiq.configure_server do |config|
  config.on(:startup) do
    cron_settings = {}

    Section.all.each do |section|
      cron_settings.merge!(
        {
          "section:#{section.id}": {
            class: 'ScanNetworkWithPingJob',
            cron: Fugit.parse(section.schedule).to_cron_s,
            args: [{ id: section.id, network: section.network }]
          }
        }
      ) unless section.schedule.nil? || section.schedule.empty?
    end

    Sidekiq::Cron::Job.load_from_hash cron_settings
  end
end
