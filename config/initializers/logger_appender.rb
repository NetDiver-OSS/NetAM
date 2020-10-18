SemanticLogger.add_appender(io: $stdout, level: :info)
SemanticLogger.add_appender(io: $stderr, level: :error)

if ENV['SYSLOG_ENABLED'].present?
  Rails.configuration.semantic_logger.add_appender(
    appender: :syslog,
    url: ENV['SYSLOG_URL']
  )
end

if ENV['SPLUNK_ENABLED'].present?
  SemanticLogger.add_appender(
    appender: :splunk_http,
    url: ENV['SPLUNK_URL'],
    token: ENV['SPLUNK_TOKEN']
  )
end

if ENV['ELASTICSEARCH_ENABLED'].present?
  SemanticLogger.add_appender(
    appender: :elasticsearch,
    url: ENV['ELASTICSEARCH_URL']
  )
end

if ENV['LOGSTASH_ENABLED'].present?
  SemanticLogger.add_appender(
    logger: LogStashLogger.new(
      type: :tcp,
      host: ENV['LOGSTASH_HOST'],
      port: ENV['LOGSTASH_PORT']
    )
  )
end
