# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Cabinets', type: :request do
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
      Cabinet.create! valid_attributes
      get cabinets_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      cabinet = Cabinet.create! valid_attributes
      get cabinet_url(cabinet)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_cabinet_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'render a successful response' do
      cabinet = Cabinet.create! valid_attributes
      get edit_cabinet_url(cabinet)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Cabinet' do
        expect {
          post cabinets_url, params: { cabinet: valid_attributes }
        }.to change(Cabinet, :count).by(1)
      end

      it 'redirects to the created cabinet' do
        post cabinets_url, params: { cabinet: valid_attributes }
        expect(response).to redirect_to(cabinet_url(Cabinet.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Cabinet' do
        expect {
          post cabinets_url, params: { cabinet: invalid_attributes }
        }.to change(Cabinet, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post cabinets_url, params: { cabinet: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) {
        skip('Add a hash of attributes valid for your model')
      }

      it 'updates the requested cabinet' do
        cabinet = Cabinet.create! valid_attributes
        patch cabinet_url(cabinet), params: { cabinet: new_attributes }
        cabinet.reload
        skip('Add assertions for updated state')
      end

      it 'redirects to the cabinet' do
        cabinet = Cabinet.create! valid_attributes
        patch cabinet_url(cabinet), params: { cabinet: new_attributes }
        cabinet.reload
        expect(response).to redirect_to(cabinet_url(cabinet))
      end
    end

    context 'with invalid parameters' do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        cabinet = Cabinet.create! valid_attributes
        patch cabinet_url(cabinet), params: { cabinet: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested cabinet' do
      cabinet = Cabinet.create! valid_attributes
      expect {
        delete cabinet_url(cabinet)
      }.to change(Cabinet, :count).by(-1)
    end

    it 'redirects to the cabinets list' do
      cabinet = Cabinet.create! valid_attributes
      delete cabinet_url(cabinet)
      expect(response).to redirect_to(cabinets_url)
    end
  end
end
