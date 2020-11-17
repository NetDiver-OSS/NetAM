require 'rails_helper'

RSpec.describe NetAM::Network::Dns do
  describe 'reverse_dns' do
    it 'should return nil if address is invalid' do
      expect(NetAM::Network::Dns.reverse_dns('')).to be_nil
      expect(NetAM::Network::Dns.reverse_dns('42')).to be_nil
      expect(NetAM::Network::Dns.reverse_dns(42)).to be_nil
      expect(NetAM::Network::Dns.reverse_dns('1.2.3.4')).to be_nil
    end

    it 'should return string if address is valid' do
      expect(NetAM::Network::Dns.reverse_dns('8.8.8.8')).to_not be_nil
      expect(NetAM::Network::Dns.reverse_dns('8.8.8.8')).to eq('dns.google')
    end
  end
end
