# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Usage, type: :model do
  subject(:usage) { described_class.new(section_id: 1, ip_used: '10.0.0.42') }

  it 'should be valid' do
    expect(usage).not_to be_valid
  end

  it 'section_id should be present' do
    usage.section_id = nil
    expect(usage).not_to be_valid
  end

  it 'ip_used should be present' do
    usage.ip_used = nil
    expect(usage).not_to be_valid
  end

  it 'identifier should be valid' do
    expect(usage.identifier).to eq('1_10.0.0.42')
  end
end
