require 'rails_helper'

RSpec.describe 'Backups', type: :request do
  before(:each) do
    admin = User.create!(email: 'admin@netam.local', password: 'azertyuiop123', admin: true)

    sign_in admin
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      get admin_backups_url
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    it 'redirects to the created user' do
      post admin_backups_url
      expect(response).to redirect_to(admin_backups_url)
    end
  end
end
