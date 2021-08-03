# frozen_string_literal: true

Sidekiq.configure_server do |config|
  config.redis = { url: ENV.fetch('REDIS_URL') { "redis://#{Rails.configuration.netdiver[:redis][:host]}:#{Rails.configuration.netdiver[:redis][:port]}/#{Rails.configuration.netdiver[:redis][:db]}" } }

  Sidekiq::Status.configure_server_middleware config
  Sidekiq::Status.configure_client_middleware config
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV.fetch('REDIS_URL') { "redis://#{Rails.configuration.netdiver[:redis][:host]}:#{Rails.configuration.netdiver[:redis][:port]}/#{Rails.configuration.netdiver[:redis][:db]}" } }

  Sidekiq::Status.configure_client_middleware config
end
