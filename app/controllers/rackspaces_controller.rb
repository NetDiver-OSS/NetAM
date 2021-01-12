# frozen_string_literal: true

class RackspacesController < ApplicationController
  load_and_authorize_resource
  before_action :set_permissions, only: %i[edit update]

  # GET /rackspaces
  def index
    @rackspaces = Rackspace.accessible_by(current_ability)
  end

  # GET /rackspaces/1
  def show
    @rack_overview = @rackspace.unit_height.downto(1).index_with { nil }

    @rackspace.devices.each do |device|
      (device.rack_occupation.rack_anchor + device.rack_height - 1).downto(device.rack_occupation.rack_anchor).each_with_index do |rack_unit, index|
        @rack_overview[rack_unit] = index.zero? ? device : false
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
    @rackspace = Rackspace.new(rackspace_params)

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
    if @rackspace.update(rackspace_params)
      redirect_to @rackspace, notice: _('Rackspace was successfully updated.')
    else
      render :edit
    end
  end

  # DELETE /rackspaces/1
  def destroy
    @rackspace.destroy
    redirect_to rackspaces_url, notice: _('Rackspace was successfully destroyed.')
  end

  private

  def set_permissions
    @permissions = Permission.where(subject_class: 'Rackspace', subject_id: @rackspace.id)
  end

  # Only allow a trusted parameter "white list" through.
  def rackspace_params
    params.require(:rackspace).permit(:name, :unit_height, :location)
  end
end
