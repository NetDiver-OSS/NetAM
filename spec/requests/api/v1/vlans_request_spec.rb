# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V1::Vlans, type: :request do
  include Rack::Test::Methods

  content_type_json = { 'CONTENT_TYPE' => 'application/json' }

  let(:api_token) do
    User.create!(email: 'admin@netdiver.local', password: 'azertyuiop123', admin: true)

    post oauth_token_path, { 'grant_type' => 'password',
                             'username' => 'admin@netdiver.local',
                             'password' => 'azertyuiop123' }, headers: content_type_json

    oauth_response = JSON.parse(last_response.body)

    "#{oauth_response['token_type']} #{oauth_response['access_token']}"
  end

  context 'with GET /api/v1/vlans' do
    it 'returns an empty array' do
      header 'Authorization', api_token
      get '/api/v1/vlans'

      expect(last_response.header['Content-Type']).to include 'application/json'
      expect(last_response.status).to eq(200)
      expect(last_response.body).not_to be_nil
    end
  end

  context 'with POST /api/v1/vlans' do
    it 'create and returns vlan' do
      header 'Authorization', api_token
      post('/api/v1/vlans', { name: 'vlan 42', vid: 42 }.to_json, content_type_json)

      expect(last_response.header['Content-Type']).to include 'application/json'
      expect(last_response.status).to eq(201)
      expect(last_response.body).not_to be_nil
    end
  end

  context 'with GET /api/v1/vlans/:id' do
    let(:vlan) { create(:vlan) }

    it 'returns a vlan' do
      header 'Authorization', api_token
      get "/api/v1/vlans/#{vlan.id}"

      expect(last_response.header['Content-Type']).to include 'application/json'
      expect(last_response.status).to eq(200)
      expect(last_response.body).to eq({ id: vlan.id, vid: vlan.vid, name: vlan.name, description: nil }.to_json)
    end
  end
end
