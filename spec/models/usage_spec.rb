# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Usage, type: :model do
  subject(:usage) { described_class.new(section_id: section.id, ip_used: '10.0.0.42') }

  let(:section) { create :section }

  it 'section_id should be present' do
    usage.section_id = nil
    expect(usage).not_to be_valid
  end

  it 'ip_used should be present' do
    usage.ip_used = nil
    expect(usage).not_to be_valid
  end

  it 'identifier should be valid' do
    usage.save!
    expect(usage.identifier).to eq("#{section.id}_10.0.0.42")
  end
end
