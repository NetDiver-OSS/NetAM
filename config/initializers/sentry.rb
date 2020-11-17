# frozen_string_literal: true

Raven.configure do |config|
  config.dsn = Rails.configuration.netam[:sentry][:dsn]
  config.environments = %w[development production]
end
