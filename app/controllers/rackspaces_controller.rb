# frozen_string_literal: true

class RackspacesController < ApplicationController
  load_and_authorize_resource
  before_action :set_permissions, only: %i[edit update]

  # GET /rackspaces
  def index
    @rackspaces = Rackspace.accessible_by(current_ability).page params[:page]
  end

  # GET /rackspaces/1
  def show
    @rack_front = @rackspace.unit_height.downto(1).index_with { nil }
    @rack_rear = @rack_front.dup

    @rackspace.devices.each do |device|
      (device.rack_occupation.rack_anchor + device.rack_height - 1).downto(device.rack_occupation.rack_anchor).each_with_index do |rack_unit, index|
        @rack_front[rack_unit] = index.zero? ? device : false
      end
    end

    @rackspace.devices.where(depth_type: :full).each do |device|
      (device.rack_occupation.rack_anchor + device.rack_height - 1).downto(device.rack_occupation.rack_anchor).each_with_index do |rack_unit, index|
        @rack_rear[rack_unit] = index.zero? ? device : false
      end
    end
  end

  # GET /rackspaces/new
  def new
    @rackspace = Rackspace.new
  end

  # GET /rackspaces/1/edit
  def edit
    # not used actually
  end

  # POST /rackspaces
  def create
    @rackspace = ::Rackspaces::CreateService.new(current_user, rackspace_params).execute

    if @rackspace.save
      Permission.create!(
        {
          user_id: current_user.id,
          subject_class: 'Rackspace',
          subject_id: @rackspace.id,
          action: 'manage'
        }
      )

      redirect_to @rackspace, notice: _('Rackspace was successfully created.')
    else
      render :new
    end
  end

  # PATCH/PUT /rackspaces/1
  def update
    if ::Rackspaces::UpdateService.new(current_user, rackspace_params.merge(rackspace: @rackspace)).execute
      redirect_to @rackspace, notice: _('Rackspace was successfully updated.')
    else
      render :edit
    end
  end

  # DELETE /rackspaces/1
  def destroy
    ::Rackspaces::DestroyService.new(current_user, rackspace: @rackspace).execute
    redirect_to rackspaces_url, notice: _('Rackspace was successfully destroyed.')
  end

  private

  def set_permissions
    @permissions = Permission.where(subject_class: 'Rackspace', subject_id: @rackspace.id)
  end

  # Only allow a trusted parameter
  def rackspace_params
    params.require(:rackspace).permit(:name, :unit_height, :location)
  end
end
