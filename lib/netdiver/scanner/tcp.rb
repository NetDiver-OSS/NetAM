# frozen_string_literal: true

require 'netdiver/scanner/base'

module NetDiver
  module Scanner
    class Tcp < Base
      def scan!
        super

        Net::Ping::TCP.new(host, port, 1).ping?
      end
    end
  end
end
