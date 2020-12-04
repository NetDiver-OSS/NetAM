# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Devices', type: :request do
  let(:admin) { create :user, :admin }
  let(:device_type) { create :device_type }

  let(:valid_attributes) do
    {
      name: 'device_test',
      device_type: device_type
    }
  end

  let(:invalid_attributes) do
    {
      name: nil,
      device_type: device_type
    }
  end

  before do
    sign_in admin
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Device.create! valid_attributes
      get devices_url
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_device_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'render a successful response' do
      device = Device.create! valid_attributes
      get edit_device_url(device)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Device' do
        expect do
          post devices_url, params: { device: valid_attributes }
        end.to change(Device, :count).by(1)
      end

      it 'redirects to the created device' do
        post devices_url, params: { device: valid_attributes }
        expect(response).to redirect_to(devices_url)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Device' do
        expect do
          post devices_url, params: { device: invalid_attributes }
        end.to change(Device, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post devices_url, params: { device: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        {
          name: 'device_test',
          device_type: device_type
        }
      end

      it 'updates the requested device' do
        device = Device.create! valid_attributes
        patch device_url(device), params: { device: new_attributes }
        device.reload
        skip('Add assertions for updated state')
      end

      it 'redirects to the device' do
        device = Device.create! valid_attributes
        patch device_url(device), params: { device: new_attributes }
        device.reload
        expect(response).to redirect_to(devices_url)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested device' do
      device = Device.create! valid_attributes
      expect do
        delete device_url(device)
      end.to change(Device, :count).by(-1)
    end

    it 'redirects to the device list' do
      device = Device.create! valid_attributes
      delete device_url(device)
      expect(response).to redirect_to(devices_url)
    end
  end
end
