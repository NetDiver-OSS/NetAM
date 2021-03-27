# frozen_string_literal: true

module NetAM
  module Utils
    class Dns
      DNS_OBJECT_TYPE = {
        A: 'A',
        AAAA: 'AAAA',
        CNAME: 'CNAME',
        MX: 'MX',
        TXT: 'TXT',
        SRV: 'SRV',
        NS: 'NS',
        SOA: 'SOA'
      }.freeze
    end
  end
end
