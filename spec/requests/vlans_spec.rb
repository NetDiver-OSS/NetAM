# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/vlans', type: :request do
  let(:admin) { create :user, :admin }

  let(:valid_attributes) do
    {
      name: 'test',
      description: 'this is a test',
      vid: 42
    }
  end

  let(:invalid_attributes) do
    {
      name: 'not test',
      description: 'this is not a test',
      vid: 'not a ID'
    }
  end

  before do
    sign_in admin
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Vlan.create! valid_attributes
      get vlans_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      vlan = Vlan.create! valid_attributes
      get vlan_url(vlan)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_vlan_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'render a successful response' do
      vlan = Vlan.create! valid_attributes
      get edit_vlan_url(vlan)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Vlan' do
        expect do
          post vlans_url, params: { vlan: valid_attributes }
        end.to change(Vlan, :count).by(1)
      end

      it 'redirects to the created vlan' do
        post vlans_url, params: { vlan: valid_attributes }
        expect(response).to redirect_to(vlan_url(Vlan.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Vlan' do
        expect do
          post vlans_url, params: { vlan: invalid_attributes }
        end.to change(Vlan, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post vlans_url, params: { vlan: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        skip('Add a hash of attributes valid for your model')
      end

      it 'updates the requested vlan' do
        vlan = Vlan.create! valid_attributes
        patch vlan_url(vlan), params: { vlan: new_attributes }
        vlan.reload
        skip('Add assertions for updated state')
      end

      it 'redirects to the vlan' do
        vlan = Vlan.create! valid_attributes
        patch vlan_url(vlan), params: { vlan: new_attributes }
        vlan.reload
        expect(response).to redirect_to(vlan_url(vlan))
      end
    end

    context 'with invalid parameters' do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        vlan = Vlan.create! valid_attributes
        patch vlan_url(vlan), params: { vlan: invalid_attributes }
        expect(response).to redirect_to(vlan_url(vlan))
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested vlan' do
      vlan = Vlan.create! valid_attributes
      expect do
        delete vlan_url(vlan)
      end.to change(Vlan, :count).by(-1)
    end

    it 'redirects to the vlans list' do
      vlan = Vlan.create! valid_attributes
      delete vlan_url(vlan)
      expect(response).to redirect_to(vlans_url)
    end
  end
end
