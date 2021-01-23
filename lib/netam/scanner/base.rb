# frozen_string_literal: true

module NetAM
  module Scanner
    class Base
      attr_reader :host, :port

      def initialize(host = nil, port = nil)
        @host = host
        @port = port
      end

      # @abstract
      def scan!
        Sidekiq.logger.info(scanner_name) { "Launch scan for address: #{host}" }
      end

      def scanner_name
        @scanner_name ||= "#{self.class.name.demodulize}Scanner"
      end
    end
  end
end
