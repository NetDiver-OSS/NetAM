# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  before(:each) do
    admin = User.create!(email: 'admin@netam.local', password: 'azertyuiop123', admin: true)

    sign_in admin
  end

  let(:valid_attributes) do
    {
      email: 'mymail@me.com',
      password: '012345678901',
      password_confirmation: '012345678901'
    }
  end

  let(:invalid_attributes) do
    {
      email: 'nop.com',
      password: '123456789012',
      password_confirmation: '567890123456'
    }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      User.create! valid_attributes
      get admin_users_url
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_admin_user_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'render a successful response' do
      user = User.create! valid_attributes
      get edit_admin_user_url(user)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new User' do
        expect do
          post admin_users_url, params: { user: valid_attributes }
        end.to change(User, :count).by(1)
      end

      it 'redirects to the created user' do
        post admin_users_url, params: { user: valid_attributes }
        expect(response).to redirect_to(admin_users_url)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new User' do
        expect do
          post admin_users_url, params: { user: invalid_attributes }
        end.to change(User, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post admin_users_url, params: { user: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        {
          email: 'mymail@me.com',
          password: '987654321012',
          password_confirmation: '987654321012'
        }
      end

      it 'updates the requested user' do
        user = User.create! valid_attributes
        patch admin_user_url(user), params: { user: new_attributes }
        user.reload
      end

      it 'redirects to the user' do
        user = User.create! valid_attributes
        patch admin_user_url(user), params: { user: new_attributes }
        user.reload
        expect(response).to redirect_to(admin_users_url)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested user' do
      user = User.create! valid_attributes
      expect do
        delete admin_user_url(user)
      end.to change(User, :count).by(-1)
    end

    it 'redirects to the users list' do
      user = User.create! valid_attributes
      delete admin_user_url(user)
      expect(response).to redirect_to(admin_users_url)
    end
  end
end
