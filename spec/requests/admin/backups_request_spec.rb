# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Backups', type: :request do
  let(:admin) { create :user, :admin }

  before(:each) do
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
