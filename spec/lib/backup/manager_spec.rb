require 'rails_helper'

RSpec.describe Backup::Manager do
  it 'should return array' do
    expect(Backup::Manager.new.list_backups).to be_an(Array)
  end
end
