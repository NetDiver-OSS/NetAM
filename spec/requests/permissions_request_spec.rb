# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Permissions', type: :request do
  let(:admin) { create :user, :admin }

  before(:each) do
    sign_in admin
  end

  let(:valid_attributes) do
    {
      name: 'permission 1',
      user_id: admin.id,
      subject_class: 'Section',
      subject_id: 1,
      action: 'manage'
    }
  end

  let(:invalid_attributes) do
    {
      name: 'permission err',
      user_id: admin.id,
      subject_class: 'Section',
      subject_id: 1,
      action: 'manage'
    }
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_permission_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'render a successful response' do
      permission = Permission.create! valid_attributes
      get edit_permission_url(permission)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Permission' do
        expect do
          post permissions_url, params: { permission: valid_attributes }
        end.to change(Permission, :count).by(1)
      end

      it 'redirects to the created permission' do
        post permissions_url, params: { permission: valid_attributes }
        expect(response).to redirect_to(root_url)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        skip('Add a hash of attributes valid for your model')
      end

      it 'updates the requested permission' do
        permission = Permission.create! valid_attributes
        patch permission_url(permission), params: { permission: new_attributes }
        permission.reload
        skip('Add assertions for updated state')
      end

      it 'redirects to the permission' do
        permission = Permission.create! valid_attributes
        patch permission_url(permission), params: { permission: new_attributes }
        permission.reload
        expect(response).to redirect_to(permission_url(permission))
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested permission' do
      permission = Permission.create! valid_attributes
      expect do
        delete permission_url(permission)
      end.to change(Permission, :count).by(-1)
    end

    it 'redirects to the permissions list' do
      permission = Permission.create! valid_attributes
      delete permission_url(permission)
      expect(response).to redirect_to(root_url)
    end
  end
end
