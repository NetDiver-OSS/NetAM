require 'rails_helper'

RSpec.describe Section, type: :model do
  context 'before publication' do
    it 'cannot have comments' do
      expect([]).to      be_empty
    end
  end
end
