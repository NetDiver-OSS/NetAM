require 'logger'

module Raven
  module Breadcrumbs
    module SentryLogger
      LEVELS = {
        ::Logger::DEBUG => 'debug',
        ::Logger::INFO => 'info',
        ::Logger::WARN => 'warn',
        ::Logger::ERROR => 'error',
        ::Logger::FATAL => 'fatal'
      }.freeze

      def add(*args)
        add_breadcrumb(*args)
        super
      end

      def add_breadcrumb(severity, message = nil, progname = nil)
        message = progname if message.nil? # see Ruby's Logger docs for why
        return if ignored_logger?(progname)
        return if message.nil? || message == ""

        # some loggers will add leading/trailing space as they (incorrectly, mind you)
        # think of logging as a shortcut to std{out,err}
        message = message.to_s.strip

        last_crumb = Raven.breadcrumbs.peek
        # try to avoid dupes from logger broadcasts
        if last_crumb.nil? || last_crumb.message != message
          Raven.breadcrumbs.record do |crumb|
            crumb.level = Raven::Breadcrumbs::SentryLogger::LEVELS.fetch(severity, nil)
            crumb.category = progname || 'logger'
            crumb.message = message
            crumb.type =
              if severity >= 3
                "error"
              else
                crumb.level
              end
          end
        end
      end

      private

      def ignored_logger?(progname)
        progname == "sentry" ||
          Raven.configuration.exclude_loggers.include?(progname)
      end
    end
    module OldBreadcrumbsSentryLogger
      def self.included(base)
        base.class_eval do
          include Raven::Breadcrumbs::SentryLogger
          alias_method :add_without_raven, :add
          alias_method :add, :add_with_raven
        end
      end

      def add_with_raven(*args)
        add_breadcrumb(*args)
        add_without_raven(*args)
      end
    end
  end
end

Raven.safely_prepend(
  "Breadcrumbs::SentryLogger",
  :from => Raven,
  :to => ::Logger
)
