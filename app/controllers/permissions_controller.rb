class PermissionsController < ApplicationController
  load_and_authorize_resource

  before_action :set_form_details, only: %i[new edit create update]

  # GET /permissions/new
  def new
    @permission = Permission.new
  end

  # GET /permissions/1/edit
  def edit
    # not used actually
  end

  # POST /permissions
  def create
    @permission = Permission.new(permission_params)

    if @permission.save
      redirect_to root_path, notice: _('Permission was successfully created.')
    else
      render :new
    end
  end

  # PATCH/PUT /permissions/1
  def update
    if @permission.update(permission_params)
      redirect_to root_path, notice: _('Permission was successfully updated.')
    else
      render :edit
    end
  end

  # DELETE /permissions/1
  def destroy
    @permission.destroy
    redirect_to root_path, notice: _('Permission was successfully destroyed.')
  end

  private

  def set_form_details
    @users = User.all.pluck(:email, :id)
  end

  # Only allow a list of trusted parameters through.
  def permission_params
    params.require(:permission).permit(:name, :user_id, :subject_class, :subject_id, :action)
  end
end
