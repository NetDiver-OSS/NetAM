# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Backup::Manager do
  it 'should return array' do
    expect(described_class.new.list_backups).to be_an(Array)
  end
end
