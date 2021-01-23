# frozen_string_literal: true

require 'netam/scanner/base'

module NetAM
  module Scanner
    class Ping < Base
      def scan!
        super

        Net::Ping::External.new(host, nil, 1).ping?
      end
    end
  end
end
