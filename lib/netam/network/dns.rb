# frozen_string_literal: true

module NetAM
  module Network
    class Dns
      def self.reverse_dns(address)
        Resolv.new.getname address.to_s
      rescue Resolv::ResolvError
        nil
      end
    end
  end
end
