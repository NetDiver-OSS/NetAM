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
