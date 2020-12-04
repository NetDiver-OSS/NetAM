# frozen_string_literal: true

class DeviceTypesController < ApplicationController
  load_resource :device
  load_and_authorize_resource
  before_action :set_permissions, only: %i[edit update]

  # GET /device_types
  def index
    @device_types = DeviceType.accessible_by(current_ability)
  end

  # GET /device_types/1
  def show
    # Not used
  end

  # GET /device_types/new
  def new
    @device_type = DeviceType.new
  end

  # GET /device_types/1/edit
  def edit
    # Not used
  end

  # POST /device_types
  def create
    @device_type = DeviceType.new(device_type_params)

    if @device_type.save
      Permission.create!(
        {
          user_id: current_user.id,
          subject_class: 'DeviceType',
          subject_id: @device_type.id,
          action: 'manage'
        }
      )

      redirect_to device_types_path, notice: _('Device type was successfully created.')
    else
      render :new
    end
  end

  # PATCH/PUT /device_types/1
  def update
    if @device_type.update(device_type_params)
      redirect_to device_types_path, notice: _('Device type was successfully updated.')
    else
      render :edit
    end
  end

  # DELETE /device_types/1
  def destroy
    if @device_type.destroy
      redirect_to device_types_url, notice: _('Device type was successfully destroyed.')
    else
      redirect_to device_types_url, alert: _('Device type was not destroyed.')
    end
  end

  private

  def set_permissions
    @permissions = Permission.where(subject_class: 'DeviceType', subject_id: @device_type.id)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_device_type
    @device_type = DeviceType.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def device_type_params
    params.require(:device_type).permit(:name, :color)
  end
end
