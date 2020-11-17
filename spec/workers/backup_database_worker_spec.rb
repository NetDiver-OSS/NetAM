# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BackupDatabaseWorker, type: :worker do
  it 'should run job' do
    expect { described_class.perform_async }.not_to raise_error
  end
end
