# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ScanAddressWithPingJob, type: :job do
  let(:section) { create(:section) }

  it 'should fail if multiple network is given' do
    expect { described_class.perform_now('10.0.0.10', '10.0.0.20') }.to raise_error(StandardError)
  end

  it 'should be nil if usage is locked' do
    usage = section.usages.create!({ ip_used: '10.0.0.250', fqdn: 'domain.com', state: 'locked' })

    expect(described_class.perform_now({ id: usage.id, ip_used: usage.ip_used, section_id: usage.section_id, state: usage.state })).to be_nil
  end

  it 'should not be true if usage is actived' do
    usage = section.usages.create!({ ip_used: '8.8.8.8', fqdn: 'domain.com', state: 'actived' })

    expect(described_class.perform_now({ id: usage.id, ip_used: usage.ip_used, section_id: usage.section_id, state: usage.state })).to be_truthy
  end

  it 'should not be true if usage is down' do
    usage = section.usages.create!({ ip_used: '5.7.0.1', fqdn: 'domain.com', state: 'down' })

    expect(described_class.perform_now({ id: usage.id, ip_used: usage.ip_used, section_id: usage.section_id, state: usage.state })).to be_truthy
  end
end
