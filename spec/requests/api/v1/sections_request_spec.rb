require 'rails_helper'

RSpec.describe API::V1::Sections, type: :request do
  include Rack::Test::Methods

  content_type_json = { 'CONTENT_TYPE' => 'application/json' }

  before(:each) do
    user = User.create!(email: "admin@netam.local", password: "azertyuiop123", admin: true)

    @api_token = APIKeys.create!({ user: user }).access_token
  end

  context 'GET /api/v1/sections' do
    it 'returns an empty array' do
      get "/api/v1/sections?token=#{@api_token}"

      expect(last_response.header['Content-Type']).to include 'application/json'
      expect(last_response.status).to eq(200)
      expect(last_response.body).not_to be_nil
    end
  end

  context 'POST /api/v1/sections' do
    it 'create and returns section' do
      post("/api/v1/sections?token=#{@api_token}", { name: 'section1', network: '10.0.0.0/24', schedule: 'every 24h' }.to_json, content_type_json)

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
      get "/api/v1/sections/#{Section.maximum(:id)}?token=#{@api_token}"

      expect(last_response.header['Content-Type']).to include 'application/json'
      expect(last_response.status).to eq(200)
      expect(last_response.body).to eq({ id: Section.maximum(:id), name: 'hell section', description: nil, network: '10.0.0.0/24', schedule: 'every 24h' }.to_json)
    end
  end

  context 'GET /api/v1/sections/:id/scan' do
    it 'launch scan for section' do
      post "/api/v1/sections/#{Section.maximum(:id)}/scan?token=#{@api_token}"

      expect(last_response.header['Content-Type']).to include 'application/json'
      expect(last_response.status).to eq(201)
      expect(last_response.body).to eq({ status: 'ack' }.to_json)
    end
  end

  context 'GET /api/v1/sections/:id/usages' do
    it 'returns usages for section' do
      get "/api/v1/sections/#{Section.maximum(:id)}/usages?token=#{@api_token}"

      expect(last_response.header['Content-Type']).to include 'application/json'
      expect(last_response.status).to eq(200)
      expect(last_response.body).not_to be_nil
    end
  end

  context 'POST /api/v1/sections/:id/usages' do
    it 'create usage for section' do
      post("/api/v1/sections/#{Section.maximum(:id)}/usages?token=#{@api_token}", { ip_used: '10.0.0.250', fqdn: 'domain.com', state: 'locked' }.to_json, content_type_json)

      expect(last_response.header['Content-Type']).to include 'application/json'
      expect(last_response.status).to eq(201)
      expect(last_response.body).to eq({ id: Usage.maximum(:id), ip_used: '10.0.0.250', fqdn: 'domain.com', description: nil, state: 'locked' }.to_json)
    end
  end
end
