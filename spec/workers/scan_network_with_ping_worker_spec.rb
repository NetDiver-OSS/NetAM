# frozen_string_literal: true

require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe ScanNetworkWithPingWorker, type: :worker do
  it 'should fail if multiple network is given' do
    expect do
      ScanNetworkWithPingWorker.new.perform({ id: 1, network: '10.0.0.0/24' }, { id: 2, network: '192.168.0.0/24' })
    end.to raise_error(RuntimeError, 'Job can only process 1 network at the time')
  end

  it 'should scan public range' do
    Vlan.create!(name: 'tu', vid: Random.rand(500))

    section = Section.create!({ name: 'google', network: '8.8.8.0/24', schedule: '', vlan_id: Vlan.first.id })

    expect { ScanNetworkWithPingWorker.new.perform({ id: section.id, network: section.network }) }.not_to raise_error
  end

  it 'should be nil if usage is locked' do
    Vlan.create!(name: 'tu', vid: Random.rand(500))

    section = Section.create!({ name: 'section', network: '10.0.0.0/24', schedule: 'every 24h', vlan_id: Vlan.first.id })

    expect { ScanNetworkWithPingWorker.new.perform({ id: section.id, network: section.network }) }.not_to raise_error
  end
end
