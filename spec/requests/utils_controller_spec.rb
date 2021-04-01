# frozen_string_literal: true

require 'rails_helper'

describe 'Util', type: :request do
  let(:admin) { create :user, :admin }

  before do
    sign_in admin
  end

  describe 'GET /utils/calculator' do
    it 'renders a successful response' do
      get utils_calculator_url
      expect(response).to be_successful
    end
  end

  describe 'GET /utils/mac_vendor' do
    it 'renders a successful response' do
      get utils_mac_vendor_url
      expect(response).to be_successful
    end
  end

  describe 'GET /utils/dns_resolver' do
    it 'renders a successful response' do
      get utils_dns_resolver_url
      expect(response).to be_successful
    end
  end
end
