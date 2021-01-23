# frozen_string_literal: true

require 'netam/scanner/base'

module NetAM
  module Scanner
    class Udp < Base
      def scan!
        super

        Net::Ping::UDP.new(host, port, 1).ping?
      end
    end
  end
end
