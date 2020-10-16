require 'rails_helper'

RSpec.describe ScanNetworkWithPingJob, type: :job do
  it "should fail if multiple network is given" do
    expect { ScanNetworkWithPingJob.perform_now('10.0.0.0/24', '192.168.0.0/24') }.to raise_error
  end

  it "should be nil if usage is locked" do
    Vlan.create!(name: 'tu', vid: Random.rand(500))

    section = Section.create!({ name: 'section', network: '10.0.0.0/24', schedule: 'every 24h', vlan_id: Vlan.first.id })

    expect { ScanNetworkWithPingJob.perform_now({ id: section.id, network: section.network }) }.not_to raise_error
  end
end
