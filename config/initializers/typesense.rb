# frozen_string_literal: true

# Create a client
TYPESENSE = Typesense::Client.new(
  nodes: [
    {
      protocol: Rails.configuration.netam.dig(:typesense, :protocol),
      host: Rails.configuration.netam.dig(:typesense, :host),
      port: Rails.configuration.netam.dig(:typesense, :port)
    }
  ],
  api_key: Rails.configuration.netam.dig(:typesense, :api_key),
  num_retries: 10,
  healthcheck_interval_seconds: 1,
  retry_interval_seconds: 0.01,
  connection_timeout_seconds: 10,
  logger: Logger.new($stdout),
  log_level: Logger::INFO
)

begin
  frontend_key_id = TYPESENSE.keys.retrieve['keys'].filter { |k| k['description'] == 'netam_frontend_key' }

  TYPESENSE.keys[frontend_key_id.first['id']].delete
rescue StandardError
  # Ignored
end

TYPESENSE_FRONTEND_KEY = TYPESENSE.keys.create(
  {
    description: 'netam_frontend_key',
    actions: %w[collections:* documents:search],
    collections: ['*']
  }
)['value']
