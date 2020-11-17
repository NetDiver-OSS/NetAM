# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Backup::Helper do
  include described_class

  it 'should return default value if env is null' do
    ENV.delete('BACKUP_PATH')
    expect(backup_path).to eq('/backups')
  end

  it 'should return env value if is set' do
    ENV['BACKUP_PATH'] = '/test-backup-path'
    expect(backup_path).to eq('/test-backup-path')
  end
end
