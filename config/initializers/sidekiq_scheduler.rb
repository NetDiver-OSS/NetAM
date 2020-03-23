require 'sidekiq'
require 'sidekiq-scheduler'

Sidekiq.configure_server do |config|

  config.on(:startup) do
    Section.all.each do |section|
      Sidekiq.set_schedule(
          "schedule:#{section.id}",
          { :class => 'ScanNetworkWithPingJob', :every => section.schedule, :queue => 'default', :args => [{:id => section.id, :network => section.network}] }
      ) unless section.schedule.nil?
    end
  end
end
