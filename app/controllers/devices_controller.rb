# frozen_string_literal: true

class DevicesController < ApplicationController
  load_resource :devices
  load_resource :devices_type
  before_action :set_devices, only: %i[create edit update destroy]

  def index
    # not used actually
  end

  def create
    # not used actually
  end

  def edit
    # not used actually
  end

  def update
    # not used actually
  end

  def destroy
    # not used actually
  end
end
