# frozen_string_literal: true

require 'rails_helper'
RSpec.describe LoadMacAddressTableWorker, type: :worker do
  it 'should fail if unable to download file' do
    expect do
      described_class.new.perform('oui.json')
    end.to raise_error(StandardError, 'Unable to download MAC Address database file')
  end

  it 'should download file' do
    expect { described_class.new.perform }.not_to raise_error
  end
end
