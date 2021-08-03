# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V1::Devices, type: :request do
  include Rack::Test::Methods

  content_type_json = { 'CONTENT_TYPE' => 'application/json' }
  let(:device_type) { create(:device_type) }

  let(:api_token) do
    User.create!(email: 'admin@netdiver.local', password: 'azertyuiop123', admin: true)

    post oauth_token_path, { 'grant_type' => 'password',
                             'username' => 'admin@netdiver.local',
                             'password' => 'azertyuiop123' }, headers: content_type_json

    oauth_response = JSON.parse(last_response.body)

    "#{oauth_response['token_type']} #{oauth_response['access_token']}"
  end

  context 'with GET /api/v1/devices' do
    it 'returns an empty array' do
      header 'Authorization', api_token
      get '/api/v1/devices'

      expect(last_response.header['Content-Type']).to include 'application/json'
      expect(last_response.status).to eq(200)
      expect(last_response.body).not_to be_nil
    end
  end

  context 'with POST /api/v1/devices' do
    it 'create and return device' do
      header 'Authorization', api_token
      post('/api/v1/devices', { name: 'test device', device_type_id: device_type.id, rack_height: 2 }.to_json, content_type_json)

      expect(last_response.header['Content-Type']).to include 'application/json'
      expect(last_response.status).to eq(201)
      expect(last_response.body).not_to be_nil
    end
  end

  context 'with GET /api/v1/devices/:id' do
    let(:device) { create(:device) }

    it 'returns a device' do
      header 'Authorization', api_token
      get "/api/v1/devices/#{device.id}"

      expect(last_response.header['Content-Type']).to include 'application/json'
      expect(last_response.status).to eq(200)
      expect(last_response.body).to eq({ id: device.id, name: device.name, rack_height: device.rack_height, depth_type: 'small', device_type_id: device.device_type_id }.to_json)
    end
  end
end
