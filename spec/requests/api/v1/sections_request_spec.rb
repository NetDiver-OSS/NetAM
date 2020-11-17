# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V1::Sections, type: :request do
  include Rack::Test::Methods

  content_type_json = { 'CONTENT_TYPE' => 'application/json' }

  let(:section) { create(:section) }
  let(:user) { create(:user, :admin) }
  let(:vlan) { create(:vlan) }

  let(:api_token) do
    post oauth_token_path, { 'grant_type' => 'password', 'username' => user.email, 'password' => user.password }, headers: content_type_json
    oauth_response = JSON.parse(last_response.body)

    "#{oauth_response['token_type']} #{oauth_response['access_token']}"
  end

  context 'with GET /api/v1/sections' do
    it 'returns an empty array' do
      header 'Authorization', api_token
      get '/api/v1/sections'

      expect(last_response.header['Content-Type']).to include 'application/json'
      expect(last_response.status).to eq(200)
      expect(last_response.body).not_to be_nil
    end
  end

  context 'with POST /api/v1/sections' do
    it 'create and returns section' do
      header 'Authorization', api_token
      post('/api/v1/sections', { name: 'section1', network: '10.0.0.0/24', schedule: 'every 24h', vlan_id: vlan.id }.to_json, content_type_json)

      expect(last_response.header['Content-Type']).to include 'application/json'
      expect(last_response.status).to eq(201)
      expect(last_response.body).not_to be_nil
    end
  end

  context 'with GET /api/v1/sections/:id' do
    it 'returns a section' do
      header 'Authorization', api_token
      get "/api/v1/sections/#{section.id}"

      expect(last_response.header['Content-Type']).to include 'application/json'
      expect(last_response.status).to eq(200)
      expect(last_response.body).to eq({ id: section.id, name: section.name, description: nil, network: section.network, schedule: 'every 24h' }.to_json)
    end
  end

  context 'with POST /api/v1/sections/:id/scan' do
    it 'launch scan for section' do
      header 'Authorization', api_token
      post "/api/v1/sections/#{section.id}/scan"

      expect(last_response.header['Content-Type']).to include 'application/json'
      expect(last_response.status).to eq(201)
      expect(last_response.body).to eq({ status: 'ack' }.to_json)
    end
  end

  context 'with GET /api/v1/sections/:id/usages' do
    it 'returns usages for section' do
      header 'Authorization', api_token
      get "/api/v1/sections/#{section.id}/usages"

      expect(last_response.header['Content-Type']).to include 'application/json'
      expect(last_response.status).to eq(200)
      expect(last_response.body).not_to be_nil
    end
  end

  context 'with POST /api/v1/sections/:id/usages' do
    it 'create usage for section' do
      header 'Authorization', api_token
      post("/api/v1/sections/#{section.id}/usages", { ip_used: '10.0.0.250', fqdn: 'domain.com', state: 'locked' }.to_json, content_type_json)

      expect(last_response.header['Content-Type']).to include 'application/json'
      expect(last_response.status).to eq(201)
      expect(last_response.body).to eq({ id: Usage.maximum(:id), ip_used: '10.0.0.250', fqdn: 'domain.com', description: nil, state: 'locked' }.to_json)
    end
  end

  context 'with POST /api/v1/sections/:id/request_ip' do
    it 'create usage for section' do
      header 'Authorization', api_token
      post("/api/v1/sections/#{section.id}/request_ip", {}, content_type_json)

      expect(last_response.status).to eq(201)
      expect(last_response.body).to eq({ id: Usage.maximum(:id), ip_used: '10.0.0.1', fqdn: nil, description: nil, state: 'actived' }.to_json)
    end
  end
end
