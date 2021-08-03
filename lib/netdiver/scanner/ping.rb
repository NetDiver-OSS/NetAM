# frozen_string_literal: true

require 'netdiver/scanner/base'

module NetDiver
  module Scanner
    class Ping < Base
      def scan!
        super

        Net::Ping::External.new(host, nil, 1).ping?
      end
    end
  end
end
