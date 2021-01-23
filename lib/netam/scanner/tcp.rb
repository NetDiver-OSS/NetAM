# frozen_string_literal: true

require 'netam/scanner/base'

module NetAM
  module Scanner
    class Tcp < Base
      def scan!
        super

        Net::Ping::TCP.new(host, port, 1).ping?
      end
    end
  end
end
