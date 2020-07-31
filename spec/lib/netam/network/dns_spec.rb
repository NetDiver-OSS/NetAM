require 'rails_helper'

RSpec.describe Netam::Network::Dns do
  describe 'reverse_dns' do
    it "should return nil if address is invalid" do
      expect(Netam::Network::Dns.reverse_dns('')).to be_nil
      expect(Netam::Network::Dns.reverse_dns('42')).to be_nil
      expect(Netam::Network::Dns.reverse_dns(42)).to be_nil
      expect(Netam::Network::Dns.reverse_dns('1.2.3.4')).to be_nil
    end

    it "should return string if address is valid" do
      expect(Netam::Network::Dns.reverse_dns('8.8.8.8')).to_not be_nil
      expect(Netam::Network::Dns.reverse_dns('8.8.8.8')).to eq('dns.google')
    end
  end
end
