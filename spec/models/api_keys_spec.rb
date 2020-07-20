require 'rails_helper'

RSpec.describe APIKeys, type: :model do
  before(:each) do
    @user = User.create!(email: "admin@netam.local", password: "azertyuiop123", admin: true)

    sign_in @user
  end

  describe '#expired?' do
    it "should be set to 1 day" do
      api_key = APIKeys.create!({ user: @user })
      expect(api_key.expired?).to be_falsey
    end
  end
end
