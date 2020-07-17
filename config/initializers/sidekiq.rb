Sidekiq.configure_server do |config|
  config.redis = { url: ENV.fetch("REDIS_URL") { "redis://#{Rails.configuration.netam[:redis][:host]}:#{Rails.configuration.netam[:redis][:port]}/#{Rails.configuration.netam[:redis][:db]}" } }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV.fetch("REDIS_URL") { "redis://#{Rails.configuration.netam[:redis][:host]}:#{Rails.configuration.netam[:redis][:port]}/#{Rails.configuration.netam[:redis][:db]}" } }
end
