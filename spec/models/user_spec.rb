# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#generate_random_password' do
    it 'should return token with 256 length' do
      expect(described_class.generate_random_password.length).to eq(256)
    end
  end
end
