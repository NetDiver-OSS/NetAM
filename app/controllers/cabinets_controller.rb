# frozen_string_literal: true

class CabinetsController < ApplicationController
  load_and_authorize_resource
  before_action :set_permissions, only: %i[edit update]

  # GET /cabinets
  def index
    @cabinets = Cabinet.accessible_by(current_ability)
  end

  # GET /cabinets/1
  def show
    # not used actually
  end

  # GET /cabinets/new
  def new
    @cabinet = Cabinet.new
  end

  # GET /cabinets/1/edit
  def edit
    # not used actually
  end

  # POST /cabinets
  def create
    @cabinet = Cabinet.new(cabinet_params)

    if @cabinet.save
      Permission.create!(
        {
          user_id: current_user.id,
          subject_class: 'Cabinet',
          subject_id: @cabinet.id,
          action: 'manage'
        }
      )

      redirect_to @cabinet, notice: _('Cabinet was successfully created.')
    else
      render :new
    end
  end

  # PATCH/PUT /cabinets/1
  def update
    if @cabinet.update(cabinet_params)
      redirect_to @cabinet, notice: _('Cabinet was successfully updated.')
    else
      render :edit
    end
  end

  # DELETE /cabinets/1
  def destroy
    @cabinet.destroy
    redirect_to cabinets_url, notice: _('Cabinet was successfully destroyed.')
  end

  private

  def set_permissions
    @permissions = Permission.where(subject_class: 'Cabinet', subject_id: @cabinet.id)
  end

  # Only allow a trusted parameter "white list" through.
  def cabinet_params
    params.require(:cabinet).permit(:name, :unit_height, :location)
  end
end
