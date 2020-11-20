# frozen_string_literal: true

Sidekiq.configure_server do |config|
  config.on(:startup) do
    cron_settings = {}

    Section.all.each do |section|
      next if section.schedule.blank?

      cron_settings.merge!(
        {
          "section:#{section.id}": {
            class: 'ScanNetworkWithPingJob',
            cron: Fugit.parse(section.schedule).to_cron_s,
            args: [{ id: section.id, network: section.network }]
          }
        }
      )
    end

    Sidekiq::Cron::Job.load_from_hash cron_settings
    Sidekiq::Cron::Job.load_from_hash YAML.load_file('config/schedule.yml')
  end
end
