# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V1::Rackspaces, type: :request do
  include Rack::Test::Methods

  content_type_json = { 'CONTENT_TYPE' => 'application/json' }

  let(:rackspace) { create(:rackspace) }
  let(:user) { create(:user, :admin) }

  let(:api_token) do
    post oauth_token_path, { 'grant_type' => 'password', 'username' => user.email, 'password' => user.password }, headers: content_type_json
    oauth_response = JSON.parse(last_response.body)

    "#{oauth_response['token_type']} #{oauth_response['access_token']}"
  end

  context 'with GET /api/v1/rackspaces' do
    it 'returns an empty array' do
      header 'Authorization', api_token
      get '/api/v1/rackspaces'

      expect(last_response.header['Content-Type']).to include 'application/json'
      expect(last_response.status).to eq(200)
      expect(last_response.body).not_to be_nil
    end
  end

  context 'with POST /api/v1/rackspaces' do
    it 'create and returns section' do
      header 'Authorization', api_token
      post('/api/v1/rackspaces', { name: 'section1', unit_height: '4', location: 'none' }.to_json, content_type_json)

      expect(last_response.header['Content-Type']).to include 'application/json'
      expect(last_response.status).to eq(201)
      expect(last_response.body).not_to be_nil
    end
  end

  context 'with GET /api/v1/rackspaces/:id' do
    it 'returns a section' do
      header 'Authorization', api_token
      get "/api/v1/rackspaces/#{rackspace.id}"

      expect(last_response.header['Content-Type']).to include 'application/json'
      expect(last_response.status).to eq(200)
      expect(last_response.body).to eq({ id: rackspace.id, name: rackspace.name, unit_height: rackspace.unit_height, location: rackspace.location }.to_json)
    end
  end
end
