# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'DeviceType', type: :request do
  let(:admin) { create :user, :admin }

  let(:valid_attributes) do
    {
      name: 'type_test',
      color: '#ff00ff'
    }
  end

  let(:invalid_attributes) do
    {
      name: nil,
      device_type: nil
    }
  end

  before do
    sign_in admin
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      DeviceType.create! valid_attributes
      get device_types_url
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_device_type_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'render a successful response' do
      device_type = DeviceType.create! valid_attributes
      get edit_device_type_url(device_type)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new DeviceType' do
        expect do
          post device_types_url, params: { device_type: valid_attributes }
        end.to change(DeviceType, :count).by(1)
      end

      it 'redirects to the created device' do
        post device_types_url, params: { device_type: valid_attributes }
        expect(response).to redirect_to(device_types_url)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new DeviceType' do
        expect do
          post device_types_url, params: { device_type: invalid_attributes }
        end.to change(DeviceType, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post device_types_url, params: { device_type: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        {
          name: 'device_test',
          color: '#0000ff'
        }
      end

      it 'updates the requested device' do
        device_type = DeviceType.create! valid_attributes
        patch device_type_url(device_type), params: { device_type: new_attributes }
        device_type.reload
        skip('Add assertions for updated state')
      end

      it 'redirects to the device' do
        device_type = DeviceType.create! valid_attributes
        patch device_type_url(device_type), params: { device_type: new_attributes }
        device_type.reload
        expect(response).to redirect_to(device_types_url)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested device' do
      device_type = DeviceType.create! valid_attributes
      expect do
        delete device_type_url(device_type)
      end.to change(DeviceType, :count).by(-1)
    end

    it 'redirects to the device list' do
      device_type = DeviceType.create! valid_attributes
      delete device_type_url(device_type)
      expect(response).to redirect_to(device_types_url)
    end
  end
end
