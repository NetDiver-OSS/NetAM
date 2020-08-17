module NetAM
  module Network
    class Range
      def initialize(network)
        @network = IPAddress(network)
      end

      def all_ips
        return [] if @network.ipv6?

        if @network.private?
          @network.hosts
        else
          @network.to_a
        end
      end

      def self.clean_display(ip)
        address = ip.to_s.split('.')
        if ip.prefix < 16
          ".#{address[1..3].join('.')}"
        elsif ip.prefix < 24
          ".#{address[2..3].join('.')}"
        else
          ".#{address[3]}"
        end
      end
    end
  end
end
