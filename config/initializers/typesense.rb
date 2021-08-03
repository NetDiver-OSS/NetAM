# frozen_string_literal: true

return unless Rails.configuration.netdiver.dig(:typesense, :enabled)

# Create a client
TYPESENSE = Typesense::Client.new(
  nodes: [
    {
      protocol: Rails.configuration.netdiver.dig(:typesense, :protocol),
      host: Rails.configuration.netdiver.dig(:typesense, :host),
      port: Rails.configuration.netdiver.dig(:typesense, :port)
    }
  ],
  api_key: Rails.configuration.netdiver.dig(:typesense, :api_key),
  num_retries: 10,
  healthcheck_interval_seconds: 1,
  retry_interval_seconds: 0.01,
  connection_timeout_seconds: 10,
  logger: Logger.new($stdout),
  log_level: Logger::INFO
)
