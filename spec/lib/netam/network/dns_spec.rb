# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NetAM::Network::Dns do
  describe 'reverse_dns' do
    it 'should return nil if address is invalid' do
      expect(described_class.reverse_dns('')).to be_nil
      expect(described_class.reverse_dns('42')).to be_nil
      expect(described_class.reverse_dns(42)).to be_nil
      expect(described_class.reverse_dns('1.2.3.4')).to be_nil
    end

    it 'should return string if address is valid' do
      expect(described_class.reverse_dns('8.8.8.8')).not_to be_nil
      expect(described_class.reverse_dns('8.8.8.8')).to eq('dns.google')
    end
  end

  describe 'dns_resolver' do
    it 'should return nil result if params is invalid' do
      expect(described_class.resolution('', '')).to include(entry: '', result: nil, type: '')
    end

    it 'should return array if params is valid' do
      expect(described_class.resolution('dns.google.com', 'A')[:result]).to be_an_instance_of(Array)
      expect(described_class.resolution('dns.google.com', 'AAAA')[:result]).to be_an_instance_of(Array)
      expect(described_class.resolution('dns.google.com', 'CNAME')).to eq(entry: 'dns.google.com', result: [], type: 'CNAME')
      expect(described_class.resolution('dns.google.com', 'MX')[:result]).to be_an_instance_of(Array)
      expect(described_class.resolution('dns.google.com', 'TXT')[:result]).to be_an_instance_of(Array)
      expect(described_class.resolution('dns.google.com', 'SRV')).to eq(entry: 'dns.google.com', result: [], type: 'SRV')
      expect(described_class.resolution('dns.google.com', 'NS')[:result]).to be_an_instance_of(Array)
      expect(described_class.resolution('dns.google.com', 'SOA')[:result]).to be_an_instance_of(Array)
    end
  end
end
