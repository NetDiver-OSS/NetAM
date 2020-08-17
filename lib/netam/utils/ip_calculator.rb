module NetAM
  module Utils
    class IPCalculator
      attr_reader :network, :mask, :nb_hosts, # shared properties
                  :broadcast, :first_address, :last_address # ipv4 specific

      PREFIX_TO_HOSTS_AVAILABLE = {
        '16777214 (/8)': 8,
        '8388606 (/9)': 9,
        '4194302 (/10)': 10,
        '2097150 (/11)': 11,
        '1048574 (/12)': 12,
        '524286 (/13)': 13,
        '262142 (/14)': 14,
        '131070 (/15)': 15,
        '65534 (/16)': 16,
        '32766 (/17)': 17,
        '16382 (/18)': 18,
        '8190 (/19)': 19,
        '4094 (/20)': 20,
        '2046 (/21)': 21,
        '1022 (/22)': 22,
        '510 (/23)': 23,
        '254 (/24)': 24,
        '126 (/25)': 25,
        '62 (/26)': 26,
        '30 (/27)': 27,
        '14 (/28)': 28,
        '6 (/29)': 29,
        '2 (/30)': 30
      }.freeze

      def initialize(address, prefix = nil)
        addr = IPAddress(address)
        addr.prefix = prefix unless prefix.nil?

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
