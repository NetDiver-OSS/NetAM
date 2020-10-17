if ENV['SYSLOG_ENABLED'].present?
  Rails.configuration.semantic_logger.add_appender(
    appender: :syslog,
    url: ENV['SYSLOG_URL']
  )
end
