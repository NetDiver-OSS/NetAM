# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Backup::Database do
  it 'should run dump' do
    ENV['BACKUP_PATH'] = './'
    # expect(Backup::Database.new.dump).to be_nil
  end
end
