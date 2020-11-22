# frozen_string_literal: true

class DevicesController < ApplicationController
  load_and_authorize_resource

  # GET /devices
  def index
    @devices = Device.all
  end

  # GET /devices/1
  def show
    # Not used
  end

  # GET /devices/new
  def new
    @device = Device.new
  end

  # GET /devices/1/edit
  def edit
    # Not used
  end

  # POST /devices
  def create
    @device = Device.new(device_params)

    if @device.save
      redirect_to @device, notice: 'Device was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /devices/1
  def update
    if @device.update(device_params)
      redirect_to @device, notice: 'Device was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /devices/1
  def destroy
    @device.destroy
    redirect_to devices_url, notice: 'Device was successfully destroyed.'
  end

  private

  # Only allow a trusted parameter "white list" through.
  def device_params
    params.require(:device).permit(:name, :h_size, :p_size)
  end
end
