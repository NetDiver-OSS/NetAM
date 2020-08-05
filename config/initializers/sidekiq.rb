Sidekiq.configure_server do |config|
  config.redis = { url: ENV.fetch("REDIS_URL") { "redis://#{Rails.configuration.netam[:redis][:host]}:#{Rails.configuration.netam[:redis][:port]}/#{Rails.configuration.netam[:redis][:db]}" } }

  Sidekiq::Status.configure_server_middleware config
  Sidekiq::Status.configure_client_middleware config
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV.fetch("REDIS_URL") { "redis://#{Rails.configuration.netam[:redis][:host]}:#{Rails.configuration.netam[:redis][:port]}/#{Rails.configuration.netam[:redis][:db]}" } }

  Sidekiq::Status.configure_client_middleware config
end
