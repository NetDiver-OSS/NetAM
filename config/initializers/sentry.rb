# frozen_string_literal: true

Sentry.init do |config|
  config.dsn = Rails.configuration.netam[:sentry][:dsn]
  config.release = NetAM::VERSION
  config.enabled_environments = %w[production]

  config.rails.report_rescued_exceptions = true
  config.breadcrumbs_logger = %i[sentry_logger active_support_logger]
end
