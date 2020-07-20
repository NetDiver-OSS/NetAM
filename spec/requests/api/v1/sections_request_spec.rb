require 'rails_helper'

RSpec.describe API::V1::Sections, type: :request do
  include Rack::Test::Methods

  def app
    API::V1::Sections
  end

  context 'GET /requests.api/requests.api.v1/sections' do
    it 'returns an empty array of statuses' do
      get '/requests.api/requests.api.v1/sections'
      expect(last_response.status).to eq(401)
    end
  end
end
