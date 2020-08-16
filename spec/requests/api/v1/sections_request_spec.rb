require 'rails_helper'

RSpec.describe API::V1::Sections, type: :request do
  include Rack::Test::Methods

  content_type_json = { 'CONTENT_TYPE' => 'application/json' }

  before(:each) do
    User.create!(email: "admin@netam.local", password: "azertyuiop123", admin: true)

    post oauth_token_path, { 'grant_type' => 'password',
                            'username'   => "admin@netam.local",
                            'password'   => "azertyuiop123"}, headers: content_type_json

    oauth_response = JSON.parse(last_response.body)

    @api_token = "#{oauth_response['token_type']} #{oauth_response['access_token']}"
  end

  context 'GET /api/v1/sections' do
    it 'returns an empty array' do
      header 'Authorization', @api_token
      get "/api/v1/sections"

      puts last_response.headers.inspect

      expect(last_response.header['Content-Type']).to include 'application/json'
      expect(last_response.status).to eq(200)
      expect(last_response.body).not_to be_nil
    end
  end

  context 'POST /api/v1/sections' do
    it 'create and returns section' do
      header 'Authorization', @api_token
      post("/api/v1/sections", { name: 'section1', network: '10.0.0.0/24', schedule: 'every 24h' }.to_json, content_type_json)

      expect(last_response.header['Content-Type']).to include 'application/json'
      expect(last_response.status).to eq(201)
      expect(last_response.body).not_to be_nil
    end
  end

  context 'GET /api/v1/sections/:id' do
    begin
      Section.create!({ name: 'hell section', network: '10.0.0.0/24', schedule: 'every 24h' })
    end

    it 'returns a section' do
      header 'Authorization', @api_token
      get "/api/v1/sections/#{Section.maximum(:id)}"

      expect(last_response.header['Content-Type']).to include 'application/json'
      expect(last_response.status).to eq(200)
      expect(last_response.body).to eq({ id: Section.maximum(:id), name: 'hell section', description: nil, network: '10.0.0.0/24', schedule: 'every 24h' }.to_json)
    end
  end

  context 'GET /api/v1/sections/:id/scan' do
    it 'launch scan for section' do
      header 'Authorization', @api_token
      post "/api/v1/sections/#{Section.maximum(:id)}/scan"

      expect(last_response.header['Content-Type']).to include 'application/json'
      expect(last_response.status).to eq(201)
      expect(last_response.body).to eq({ status: 'ack' }.to_json)
    end
  end

  context 'GET /api/v1/sections/:id/usages' do
    it 'returns usages for section' do
      header 'Authorization', @api_token
      get "/api/v1/sections/#{Section.maximum(:id)}/usages"

      expect(last_response.header['Content-Type']).to include 'application/json'
      expect(last_response.status).to eq(200)
      expect(last_response.body).not_to be_nil
    end
  end

  context 'POST /api/v1/sections/:id/usages' do
    it 'create usage for section' do
      header 'Authorization', @api_token
      post("/api/v1/sections/#{Section.maximum(:id)}/usages", { ip_used: '10.0.0.250', fqdn: 'domain.com', state: 'locked' }.to_json, content_type_json)

      expect(last_response.header['Content-Type']).to include 'application/json'
      expect(last_response.status).to eq(201)
      expect(last_response.body).to eq({ id: Usage.maximum(:id), ip_used: '10.0.0.250', fqdn: 'domain.com', description: nil, state: 'locked' }.to_json)
    end
  end
end
