require 'rails_helper'

RSpec.describe ExportSectionToCsvJob, type: :job do
  it "should return csv" do
    Vlan.create!(name: 'tu', vid: Random.rand(500))

    section = Section.create!({ name: 'TU', network: '10.0.0.0/24', schedule: 'every 24h', vlan_id: Vlan.first.id })
    section.usages.create!({ ip_used: '10.0.0.250', fqdn: 'domain.com', state: 'locked' })
    section.usages.create!({ ip_used: '10.0.0.251', fqdn: 'domain.com', state: 'actived' })
    section.usages.create!({ ip_used: '10.0.0.252', fqdn: 'domain.com', state: 'down' })
    section.usages.create!({ ip_used: '10.0.0.253', fqdn: 'domain.com', state: 'dhcp' })

    expect(ExportSectionToCsvJob.perform_now(section.id)).to eq(
      """ID,Section,Address,FQDN,Description,State
#{section.id},TU,10.0.0.250,domain.com,,Reserved
#{section.id},TU,10.0.0.251,domain.com,,Active
#{section.id},TU,10.0.0.252,domain.com,,Inactive
#{section.id},TU,10.0.0.253,domain.com,,DHCP
"""
    )
  end
end
