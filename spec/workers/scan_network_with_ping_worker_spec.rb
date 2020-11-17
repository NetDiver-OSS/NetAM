# frozen_string_literal: true

require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe ScanNetworkWithPingWorker, type: :worker do
  let(:section) { create(:section) }

  it 'should fail if multiple network is given' do
    expect do
      described_class.new.perform({ id: 1, network: '10.0.0.0/24' }, { id: 2, network: '192.168.0.0/24' })
    end.to raise_error(RuntimeError, 'Job can only process 1 network at the time')
  end

  it 'should scan public range' do
    expect { described_class.new.perform({ id: section.id, network: section.network }) }.not_to raise_error
  end
end
