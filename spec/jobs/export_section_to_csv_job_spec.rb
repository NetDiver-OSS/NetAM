# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ExportSectionToCsvJob, type: :job do
  let(:section) { create(:section) }

  before do
    section.usages.create!({ ip_used: '10.0.0.250', fqdn: 'domain.com', state: 'locked' })
    section.usages.create!({ ip_used: '10.0.0.251', fqdn: 'domain.com', state: 'actived' })
    section.usages.create!({ ip_used: '10.0.0.252', fqdn: 'domain.com', state: 'down' })
    section.usages.create!({ ip_used: '10.0.0.253', fqdn: 'domain.com', state: 'dhcp' })
  end

  it 'should return csv' do
    expect(described_class.perform_now(section.id)).to eq(
      <<~CSV
        id,section,ip,hostname,description,state
        #{section.id},#{section.name},10.0.0.250,domain.com,,LOCKED
        #{section.id},#{section.name},10.0.0.251,domain.com,,ACTIVED
        #{section.id},#{section.name},10.0.0.252,domain.com,,DOWN
        #{section.id},#{section.name},10.0.0.253,domain.com,,DHCP
      CSV
    )
  end
end
