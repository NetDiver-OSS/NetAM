# frozen_string_literal: true

require 'netdiver/scanner/base'

module NetDiver
  module Scanner
    class Udp < Base
      def scan!
        super

        Net::Ping::UDP.new(host, port, 1).ping?
      end
    end
  end
end
