require 'rails_helper'

RSpec.describe "APIKeys", type: :request do
  before(:each) do
    @user = User.create!(email: "admin@netam.local", password: "azertyuiop123", admin: true)

    sign_in @user
  end

  describe "GET /index" do
    it "renders a successful response" do
      APIKeys.create!({ user: @user })
      get api_keys_url
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    it "creates a new api_key" do
      expect do
        post api_keys_url
        puts response.body.inspect
      end.to change(APIKeys, :count).by(1)
    end

    it "redirects to the created api_key" do
      post api_keys_url
      expect(response).to redirect_to(api_keys_url)
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested api_key" do
      api_key = APIKeys.create!({ user: @user })
      expect do
        delete api_key_path(api_key)
      end.to change(APIKeys, :count).by(-1)
    end

    it "redirects to the api_key list" do
      api_key = APIKeys.create!({ user: @user })
      delete api_key_url(api_key)
      expect(response).to redirect_to(api_keys_url)
    end
  end
end
