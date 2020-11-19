# frozen_string_literal: true

require 'rails_helper'

RSpec.describe IngestOuiDatabaseWorker, type: :worker do
  before do
    FileUtils.cp Rails.root.join('spec/fixtures/oui.txt'), Rails.root.join('tmp/oui.txt')
  end

  it 'should insert mac addresses into database' do
    described_class.new.perform

    expect(MacAddress.count).to eq(6)
  end
end
