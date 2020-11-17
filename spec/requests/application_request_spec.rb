require 'rails_helper'

RSpec.describe 'Application', type: :request do
  before(:each) do
    admin = User.create!(email: 'admin@netam.local', password: 'azertyuiop123', admin: true)

    sign_in admin
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      get root_url
      expect(response).to be_successful
    end
  end
end
