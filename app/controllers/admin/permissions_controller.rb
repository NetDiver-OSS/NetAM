class Admin::PermissionsController < ApplicationController
  load_and_authorize_resource

  # GET /permissions
  def index
    @permissions = Permission.all
  end

  # GET /permissions/1
  def show
  end

  # GET /permissions/new
  def new
    @permission = Permission.new
  end

  # GET /permissions/1/edit
  def edit
  end

  # POST /permissions
  def create
    @permission = Permission.new(permission_params)

    if @permission.save
      redirect_to @permission, notice: 'Permission was successfully created.'
    else
      render :new
    end

  end

  # PATCH/PUT /permissions/1
  def update
    if @permission.update(permission_params)
      redirect_to @permission, notice: 'Permission was successfully updated.'
    else
      render :edit
    end
  end


  # DELETE /permissions/1
  def destroy
    @permission.destroy
    redirect_to admin_permissions_path, notice: 'Section was successfully destroyed.'
  end

  private

  # Only allow a list of trusted parameters through.
  def permission_params
    params.require(:permission).permit(:name, :subject_class, :subject_id, :action)
  end
end
