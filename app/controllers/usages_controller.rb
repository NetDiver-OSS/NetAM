# frozen_string_literal: true

class UsagesController < ApplicationController
  load_resource :section
  load_and_authorize_resource :usage, through: :section

  before_action :set_section
  before_action :set_usage, only: %i[show edit update destroy]

  # GET /usages
  def index
    @usages = @section.usages
  end

  # GET /usages/1
  def show
    # not used actually
  end

  # GET /usages/new
  def new
    @usage = @section.usages.build
  end

  # GET /usages/1/edit
  def edit
    # not used actually
  end

  # POST /usages/1/scan
  def scan
    @usage = Usage.find(params[:usage_id])

    ScanAddressWithPingJob.perform_later({ id: @usage.id, ip_used: @usage.ip_used, section_id: @usage.section_id, state: @usage.state })

    redirect_to section_path(@usage.section_id), notice: _('Scan was successfully scheduled.')
  end

  # POST /usages
  def create
    @usage = @section.usages.build(usage_params)

    if @usage.save
      if @usage.define_device == '1' && @usage.fqdn.present?
        @usage.update!(device: Device.create!(name: @usage.fqdn, rack_height: 1, device_type: DeviceType.find_by(name: 'None')))
        Permission.create!(
          {
            user_id: current_user.id,
            subject_class: 'Device',
            subject_id: @usage.device.id,
            action: 'manage'
          }
        )
      end
      redirect_to section_path(@usage.section_id), notice: _('Usage was successfully created.')
    else
      render :new
    end
  end

  # PATCH/PUT /usages/1
  def update
    if ::Usages::UpdateService.new(current_user, usage_params.merge(usage: @usage)).execute
      if @usage.define_device == '1' && @usage.fqdn.present?
        @usage.update!(device: Device.create!(name: @usage.fqdn, rack_height: 1, device_type: DeviceType.find_by(name: 'None')))
        Permission.create!(
          {
            user_id: current_user.id,
            subject_class: 'Device',
            subject_id: @usage.device.id,
            action: 'manage'
          }
        )
      end
      if @usage.define_device == '0' && @usage.fqdn.present?
        @usage.update!(device: nil)
        Device.destroy_by(name: @usage.fqdn)
      end
      redirect_to section_path(@usage.section_id), notice: _('Usage was successfully updated.')
    else
      render :edit
    end
  end

  # DELETE /usages/1
  def destroy
    @usage.destroy
    redirect_to section_path(@usage.section_id), notice: _('Usage was successfully destroyed.')
  end

  # GET /usages/import
  def import
    Usage.import(@section.id, params[:file])
    redirect_to section_path(@section)
  end

  private

  def set_section
    @section = Section.find(params[:section_id])
  end

  def set_usage
    @usage = Usage.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def usage_params
    params.require(:usage).permit(:ip_used, :fqdn, :description, :state, :section_id, :define_device)
  end
end
