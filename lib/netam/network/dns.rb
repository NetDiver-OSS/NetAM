# frozen_string_literal: true

module NetAM
  module Network
    class Dns
      def self.reverse_dns(address)
        Resolv.new.getname address.to_s
      rescue Resolv::ResolvError
        nil
      end

      def self.resolution(entry, type)
        result = Resolv::DNS.open do |dns|
          case type
          when 'A', 'AAAA'
            records = dns.getresources(entry, "Resolv::DNS::Resource::IN::#{type}".constantize)
            records.empty? ? [] : records.map { |r| r.address.to_s }
          when 'CNAME', 'NS'
            records = dns.getresources(entry, "Resolv::DNS::Resource::IN::#{type}".constantize)
            records.empty? ? [] : records.map { |r| r.name.to_s }
          when 'MX'
            records = dns.getresources(entry, Resolv::DNS::Resource::IN::MX)
            records.empty? ? [] : records.map { |r| "#{r.preference} #{r.exchange}" }
          when 'TXT'
            records = dns.getresources(entry, Resolv::DNS::Resource::IN::TXT)
            records.empty? ? [] : records.map(&:data)
          when 'SRV'
            records = dns.getresources(entry, Resolv::DNS::Resource::IN::SRV)
            records.empty? ? [] : records.map { |r| "Port : #{r.port}, Priority : #{r.priority}, Target : #{r.target}, Weight : #{r.weight}" }
          when 'SOA'
            records = dns.getresources(entry, Resolv::DNS::Resource::IN::SOA)
            records.empty? ? [] : records.map { |r| "Serial : #{r.serial}, Host : #{r.mname}, Maintainer : #{r.rname}" }
          else
            nil
          end
        end

        {
          entry: entry,
          type: type,
          result: result
        }
      rescue Resolv::ResolvError
        nil
      end
    end
  end
end
