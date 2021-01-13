# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Rackspace, type: :model do
  subject(:rackspace) { described_class.new(name: 'TU rack') }

  it 'unit_height should be present' do
    rackspace.unit_height = nil
    expect(rackspace).not_to be_valid
  end

  it 'unit_height should be integer' do
    rackspace.unit_height = '42'
    expect(rackspace).not_to be_valid
  end

  it 'location should be present' do
    rackspace.location = nil
    expect(rackspace).not_to be_valid
  end
end
