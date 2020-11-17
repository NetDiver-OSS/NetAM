# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Usage', type: :request do
  let(:admin) { create :user, :admin }
  let(:section) { create :section }

  before(:each) do
    sign_in admin
  end

  let(:valid_attributes) do
    {
      section_id: section.id,
      ip_used: '10.0.0.250',
      fqdn: 'domain.com',
      state: 'locked'
    }
  end

  let(:invalid_attributes) do
    {
      section_id: section.id,
      ip_used: '10.0.0.250',
      fqdn: 'domain.com',
      state: 'locked'
    }
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_section_usage_url(section_id: section.id)
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'render a successful response' do
      usage = Usage.create! valid_attributes
      get edit_section_usage_url(section_id: section.id, id: usage.id)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Usage' do
        expect do
          post section_usages_url(section_id: section.id), params: { usage: valid_attributes }
        end.to change(Usage, :count).by(1)
      end

      it 'redirects to the created usage' do
        post section_usages_url(section_id: section.id), params: { usage: valid_attributes }
        expect(response).to redirect_to(section_url(section.id))
      end
    end

    # context "with invalid parameters" do
    #   it "does not create a new Usage" do
    #     expect do
    #       post section_usages_url(section_id: section.id), params: { usage: invalid_attributes }
    #     end.to change(Usage, :count).by(0)
    #   end
    #
    #   it "renders a successful response (i.e. to display the 'new' template)" do
    #     post section_usages_url(section_id: section.id), params: { usage: invalid_attributes }
    #     expect(response).to be_successful
    #   end
    # end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        skip('Add a hash of attributes valid for your model')
      end

      it 'updates the requested usage' do
        usage = Usage.create! valid_attributes
        patch section_usage_url(section_id: section.id, id: usage.id), params: { usage: new_attributes }
        usage.reload
        skip('Add assertions for updated state')
      end

      it 'redirects to the usage' do
        usage = Usage.create! valid_attributes
        patch section_usage_url(section_id: section.id, id: usage.id), params: { usage: new_attributes }
        usage.reload
        expect(response).to redirect_to(section_usage_url(usage))
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested usage' do
      usage = Usage.create! valid_attributes
      expect do
        delete section_usage_url(section_id: section.id, id: usage.id)
      end.to change(Usage, :count).by(-1)
    end

    it 'redirects to the usages list' do
      usage = Usage.create! valid_attributes
      delete section_usage_url(section_id: section.id, id: usage.id)
      expect(response).to redirect_to(section_url(section.id))
    end
  end

  describe 'POST /import' do
    it 'should create usage' do
      expect do
        post import_section_usages_path(section.id), params: { file: Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/netam_import_usages.csv')) }
      end.to change(Usage, :count).by(1)
    end
  end
end
