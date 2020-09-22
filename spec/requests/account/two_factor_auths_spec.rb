require 'rails_helper'

RSpec.describe "TwoFactorAuth", type: :request do
  before(:each) do
    admin = User.create!(email: "admin@netam.local", password: "azertyuiop123", admin: true)

    sign_in admin
  end

  describe "POST /" do
    it "create 2FA codes" do
      post account_two_factor_auths_url
      expect(response).to be_successful
    end
  end

  describe "DELETE /" do
    it "delete 2FA codes" do
      delete account_two_factor_auths_url
      expect(response).to be_successful
    end
  end
end
