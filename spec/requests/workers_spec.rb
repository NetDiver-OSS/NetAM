# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/workers', type: :request do
  let(:admin) { create :user, :admin }

  let(:valid_attributes) do
    { name: 'worker1' }
  end

  let(:new_attributes) do
    { name: 'worker42' }
  end

  before do
    sign_in admin
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Worker.create! valid_attributes
      get admin_workers_url
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_admin_worker_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'render a successful response' do
      worker = Worker.create! valid_attributes
      get edit_admin_worker_url(worker)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Worker' do
        expect do
          post admin_workers_url, params: { worker: valid_attributes }
        end.to change(Worker, :count).by(1)
      end

      it 'redirects to the created worker' do
        post admin_workers_url, params: { worker: valid_attributes }
        expect(response).to redirect_to(admin_workers_url)
      end
    end

    # context "with invalid parameters" do
    #   it "does not create a new Worker" do
    #     expect do
    #       post admin_workers_url, params: { worker: invalid_attributes }
    #     end.to change(Worker, :count).by(0)
    #   end
    #
    #   it "renders a successful response (i.e. to display the 'new' template)" do
    #     post admin_workers_url, params: { worker: invalid_attributes }
    #     expect(response).to be_successful
    #   end
    # end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      it 'updates the requested worker' do
        worker = Worker.create! valid_attributes
        patch admin_worker_url(worker), params: { worker: new_attributes }
        worker.reload
      end

      it 'redirects to the worker' do
        worker = Worker.create! valid_attributes
        patch admin_worker_url(worker), params: { worker: new_attributes }
        worker.reload
        expect(response).to redirect_to(admin_workers_url)
      end
    end

    # context "with invalid parameters" do
    #   it "renders a successful response (i.e. to display the 'edit' template)" do
    #     worker = Worker.create! valid_attributes
    #     patch admin_worker_url(worker), params: { worker: invalid_attributes }
    #     expect(response).to be_successful
    #   end
    # end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested worker' do
      worker = Worker.create! valid_attributes
      expect do
        delete admin_worker_url(worker)
      end.to change(Worker, :count).by(-1)
    end

    it 'redirects to the workers list' do
      worker = Worker.create! valid_attributes
      delete admin_worker_url(worker)
      expect(response).to redirect_to(admin_workers_url)
    end
  end
end
