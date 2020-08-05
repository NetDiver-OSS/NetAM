module NetAM
  module Utils
    class IPCalculator
      attr_reader :network, :mask, :nb_hosts, # shared properties
                  :broadcast, :first_address, :last_address # ipv4 specific

      def initialize(address)
        addr = IPAddress(address)

        @network = addr.network.to_s
        @mask = addr.prefix.to_i

        if addr.ipv4?
          @broadcast = addr.broadcast.to_s
          @nb_hosts = (addr.size.to_i - 2).abs

          @first_address = addr.first.to_s
          @last_address = addr.last.to_s
        end

        @nb_hosts = addr.size if addr.ipv6?
      end
    end
  end
end
