# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Cabinet, type: :model do
  subject(:cabinet) { described_class.new(name: 'TU rack') }

  it 'unit_height should be present' do
    cabinet.unit_height = nil
    expect(cabinet).not_to be_valid
  end

  it 'unit_height should be integer' do
    cabinet.unit_height = '42'
    expect(cabinet).not_to be_valid
  end

  it 'location should be present' do
    cabinet.location = nil
    expect(cabinet).not_to be_valid
  end
end
