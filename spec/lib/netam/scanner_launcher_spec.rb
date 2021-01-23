# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NetAM::ScannerLauncher do
  let(:vlan) { create(:vlan) }

  describe 'run' do
    let(:section) { create(:section) }

    it 'should raise if job not exist' do
      expect { described_class.new('ScanNetworkWithNothingJob').run(section.id, section.network) }.to raise_error(NameError)
    end

    it 'should return job_id' do
      expect(described_class.new('ScanNetworkWithPingWorker').run(section.id, section.network)).to be_a(String)
      expect(described_class.new('ScanNetworkWithPingWorker').run(section.id, section.network)).to match(/[a-z0-9]/)
    end
  end

  describe 'status' do
    it 'should return nil if job_id not exist' do
      expect(described_class.status('')).to be_nil
      expect(described_class.status(42)).to be_nil
      expect(described_class.status('42')).to be_nil
    end
  end
end
