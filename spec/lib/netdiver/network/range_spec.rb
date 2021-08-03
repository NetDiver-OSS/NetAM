# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NetDiver::Network::Range do
  describe '#all_ips' do
    context 'with ipv4' do
      context 'when private' do
        context 'when class B' do
          it 'should be return 65534 ip' do
            expect(described_class.new('172.16.10.0/16').all_ips.size).to eq(65_534)
          end
        end

        context 'when class C' do
          it 'should be return 254 ip' do
            expect(described_class.new('192.168.1.0/24').all_ips.size).to eq(254)
          end
        end
      end

      context 'when public' do
        it 'should be return 2048 ip' do
          expect(described_class.new('109.205.0.0/21').all_ips.size).to eq(2048)
        end
      end
    end
  end

  describe '#clean_display' do
    it 'should return last block of ip' do
      expect(described_class.clean_display(IPAddress('192.168.2.128/32'))).to eq('.128')
    end

    it 'should return 2 last block of ip' do
      expect(described_class.clean_display(IPAddress('172.16.10.52/16'))).to eq('.10.52')
    end

    it 'should return 3 last block of ip' do
      expect(described_class.clean_display(IPAddress('10.20.30.40/8'))).to eq('.20.30.40')
    end
  end
end
