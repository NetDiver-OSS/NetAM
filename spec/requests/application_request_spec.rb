# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Application', type: :request do
  let(:admin) { create :user, :admin }

  before do
    sign_in admin
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      get root_url
      expect(response).to be_successful
    end
  end
end
