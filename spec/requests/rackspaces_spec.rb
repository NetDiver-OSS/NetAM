# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Rackspaces', type: :request do
  let(:admin) { create :user, :admin }

  let(:valid_attributes) do
    {
      name: 'test',
      location: 'home',
      unit_height: 42
    }
  end

  let(:invalid_attributes) do
    {
      name: 'not test',
      location: 'home',
      unit_height: 'not a ID'
    }
  end

  before do
    sign_in admin
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Rackspace.create! valid_attributes
      get rackspaces_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      rackspace = Rackspace.create! valid_attributes
      get rackspace_url(rackspace)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_rackspace_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'render a successful response' do
      rackspace = Rackspace.create! valid_attributes
      get edit_rackspace_url(rackspace)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Rackspace' do
        expect do
          post rackspaces_url, params: { rackspace: valid_attributes }
        end.to change(Rackspace, :count).by(1)
      end

      it 'redirects to the created rackspace' do
        post rackspaces_url, params: { rackspace: valid_attributes }
        expect(response).to redirect_to(rackspace_url(Rackspace.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new rackspace' do
        expect do
          post rackspaces_url, params: { rackspace: invalid_attributes }
        end.to change(Rackspace, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post rackspaces_url, params: { rackspace: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        skip('Add a hash of attributes valid for your model')
      end

      it 'updates the requested rackspace' do
        rackspace = Rackspace.create! valid_attributes
        patch rackspace_url(rackspace), params: { rackspace: new_attributes }
        rackspace.reload
        skip('Add assertions for updated state')
      end

      it 'redirects to the rackspace' do
        rackspace = Rackspace.create! valid_attributes
        patch rackspace_url(rackspace), params: { rackspace: new_attributes }
        rackspace.reload
        expect(response).to redirect_to(rackspace_url(rackspace))
      end
    end

    context 'with invalid parameters' do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        rackspace = Rackspace.create! valid_attributes
        patch rackspace_url(rackspace), params: { rackspace: invalid_attributes }
        expect(response).to redirect_to(rackspace_url(rackspace))
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested rackspace' do
      rackspace = Rackspace.create! valid_attributes
      expect do
        delete rackspace_url(rackspace)
      end.to change(Rackspace, :count).by(-1)
    end

    it 'redirects to the rackspaces list' do
      rackspace = Rackspace.create! valid_attributes
      delete rackspace_url(rackspace)
      expect(response).to redirect_to(rackspaces_url)
    end
  end
end
