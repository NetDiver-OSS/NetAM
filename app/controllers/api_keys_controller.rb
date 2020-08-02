class APIKeysController < ApplicationController
  # GET /api_keys
  def index
    @api_keys = APIKeys.where(user: current_user)
  end

  # POST /api_keys
  def create
    APIKeys.create(user: current_user)
    redirect_to api_keys_path, notice: 'APIKeys was successfully created.'
  end

  # DELETE /api_keys/1
  def destroy
    APIKeys.find(params[:id]).destroy
    redirect_to api_keys_path, notice: 'APIKeys was successfully destroyed.'
  end
end
