# frozen_string_literal: true

class DevicesController < ApplicationController
  load_and_authorize_resource
  before_action :set_permissions, only: %i[edit update]
  before_action :set_device_types, only: %i[create update new edit]

  # GET /devices
  def index
    @devices = Device.accessible_by(current_ability).page params[:page]
  end

  # GET /devices/1
  def show
    # Not used
  end

  # GET /devices/new
  def new
    @device = Device.new
    2.times { @device.build_rack_occupation }
  end

  # GET /devices/1/edit
  def edit
    2.times { @device.build_rack_occupation } if @device.rack_occupation.nil?
  end

  # POST /devices
  def create
    @device = ::Devices::CreateService.new(current_user, device_params).execute

    if @device.save
      redirect_to devices_path, notice: _('Device was successfully created.')
    else
      render :new
    end
  end

  # PATCH/PUT /devices/1
  def update
    if ::Devices::UpdateService.new(current_user, device_params.merge(device: @device)).execute
      redirect_to devices_path, notice: _('Device was successfully updated.')
    else
      render :edit
    end
  end

  # DELETE /devices/1
  def destroy
    ::Devices::DestroyService.new(current_user, device: @device).execute
    redirect_to devices_url, notice: _('Device was successfully destroyed.')
  end

  private

  def set_permissions
    @permissions = Permission.where(subject_class: 'Device', subject_id: @device.id)
  end

  def set_device_types
    @device_types = DeviceType.all.pluck(:name, :id)
  end

  # Only allow a trusted parameter
  def device_params
    params.require(:device).permit(:name, :rack_height, :depth_type, :device_type_id, rack_occupation_attributes: %i[id rackspace_id rack_anchor _destroy])
  end
end
