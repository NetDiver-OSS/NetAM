require 'rails_helper'

RSpec.describe Netam do
  describe 'VERSION' do
    it "should return version" do
      expect(Netam::VERSION).to_not be_nil
    end
  end
end
