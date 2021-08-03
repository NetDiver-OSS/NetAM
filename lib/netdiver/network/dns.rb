# frozen_string_literal: true

module NetDiver
  module Network
    class Dns
      def self.reverse_dns(address)
        Resolv.new.getname address.to_s
      rescue Resolv::ResolvError
        nil
      end

      def self.resolution(entry, type)
        result = Resolv::DNS.open do |dns|
          type.empty? ? 'empty' : records = dns.getresources(entry, "Resolv::DNS::Resource::IN::#{type}".constantize)
          case type
          when 'A', 'AAAA'
            records.empty? ? [] : records.map { |r| r.address.to_s }
          when 'CNAME', 'NS'
            records.empty? ? [] : records.map { |r| r.name.to_s }
          when 'MX'
            records.empty? ? [] : records.map { |r| "#{r.preference} #{r.exchange}" }
          when 'TXT'
            records.empty? ? [] : records.map(&:data)
          when 'SRV'
            records.empty? ? [] : records.map { |r| "Port : #{r.port}, Priority : #{r.priority}, Target : #{r.target}, Weight : #{r.weight}" }
          when 'SOA'
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
      end
    end
  end
end
