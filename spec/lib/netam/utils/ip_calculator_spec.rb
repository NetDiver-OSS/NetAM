# frozen_string_literal: true

require 'rails_helper'

describe NetAM::Utils::IPCalculator do
  let(:ipv4) { NetAM::Utils::IPCalculator.new('10.0.0.10/24') }
  let(:ipv6) { NetAM::Utils::IPCalculator.new('2a01:eb1f:80c2:200::42/64') }

  context 'with ipv4 value' do
    it 'should return full model' do
      expect(ipv4.network).to_not be_nil
      expect(ipv4.mask).to_not be_nil
      expect(ipv4.nb_hosts).to_not be_nil
      expect(ipv4.broadcast).to_not be_nil
      expect(ipv4.first_address).to_not be_nil
      expect(ipv4.last_address).to_not be_nil
    end

    context 'ipv4 class A' do
      let(:class_a) { NetAM::Utils::IPCalculator.new('10.0.0.10/8') }

      it 'should return right value for class A' do
        expect(class_a.network).to eq('10.0.0.0')
        expect(class_a.mask).to eq(8)
        expect(class_a.nb_hosts).to eq(16_777_214)
      end
    end

    context 'ipv4 class B' do
      let(:class_b) { NetAM::Utils::IPCalculator.new('172.16.20.30/16') }

      it 'should return right value for class B' do
        expect(class_b.network).to eq('172.16.0.0')
        expect(class_b.mask).to eq(16)
        expect(class_b.nb_hosts).to eq(65_534)
      end
    end

    context 'ipv4 class C' do
      let(:class_c) { NetAM::Utils::IPCalculator.new('192.168.1.40/24') }

      it 'should return right value for class C' do
        expect(class_c.network).to eq('192.168.1.0')
        expect(class_c.mask).to eq(24)
        expect(class_c.nb_hosts).to eq(254)
      end
    end
  end

  context 'with ipv6 value' do
    it 'should return limited model' do
      expect(ipv6.network).to_not be_nil
      expect(ipv6.mask).to_not be_nil
      expect(ipv6.nb_hosts).to_not be_nil
      expect(ipv6.broadcast).to be_nil
      expect(ipv6.first_address).to be_nil
      expect(ipv6.last_address).to be_nil
    end
  end
end
