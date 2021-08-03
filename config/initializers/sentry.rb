# frozen_string_literal: true

Sentry.init do |config|
  config.dsn = Rails.configuration.netdiver[:sentry][:dsn]
  config.release = NetDiver::VERSION
  config.enabled_environments = %w[production]

  config.rails.report_rescued_exceptions = true
  config.breadcrumbs_logger = %i[sentry_logger active_support_logger]
end
