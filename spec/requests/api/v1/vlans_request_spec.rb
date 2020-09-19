require 'rails_helper'

RSpec.describe API::V1::Vlans, type: :request do
  include Rack::Test::Methods

  content_type_json = { 'CONTENT_TYPE' => 'application/json' }

  before(:each) do
    User.create!(email: "admin@netam.local", password: "azertyuiop123", admin: true)

    post oauth_token_path, { 'grant_type' => 'password',
                             'username' => "admin@netam.local",
                             'password' => "azertyuiop123" }, headers: content_type_json

    oauth_response = JSON.parse(last_response.body)

    @api_token = "#{oauth_response['token_type']} #{oauth_response['access_token']}"
  end

  context 'GET /api/v1/vlans' do
    it 'returns an empty array' do
      header 'Authorization', @api_token
      get "/api/v1/vlans"

      expect(last_response.header['Content-Type']).to include 'application/json'
      expect(last_response.status).to eq(200)
      expect(last_response.body).not_to be_nil
    end
  end

  context 'POST /api/v1/vlans' do
    it 'create and returns vlan' do
      header 'Authorization', @api_token
      post("/api/v1/vlans", { name: 'vlan 42', vid: 42 }.to_json, content_type_json)

      expect(last_response.header['Content-Type']).to include 'application/json'
      expect(last_response.status).to eq(201)
      expect(last_response.body).not_to be_nil
    end
  end

  context 'GET /api/v1/vlans/:id' do
    it 'returns a vlan' do
      @vid = Random.rand(1_000)
      Vlan.create!({ name: 'vlan 142', vid: @vid })

      header 'Authorization', @api_token
      get "/api/v1/vlans/#{Vlan.maximum(:id)}"

      expect(last_response.header['Content-Type']).to include 'application/json'
      expect(last_response.status).to eq(200)
      expect(last_response.body).to eq({ id: Vlan.maximum(:id), vid: @vid, name: 'vlan 142', description: nil }.to_json)
    end
  end

end
