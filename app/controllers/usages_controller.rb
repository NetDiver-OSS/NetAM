class UsagesController < ApplicationController
  before_action :set_usage, only: [:show, :edit, :update, :destroy]

  # GET /usages
  def index
    @usages = Usage.all
  end

  # GET /usages/1
  def show
  end

  # GET /usages/new
  def new
    @usage = Usage.new
  end

  # GET /usages/1/edit
  def edit
  end

  # POST /usages
  def create
    @usage = Usage.new(usage_params)

    if @usage.save
      redirect_to @usage, notice: 'Usage was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /usages/1
  def update
    if @usage.update(usage_params)
      redirect_to @usage, notice: 'Usage was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /usages/1
  def destroy
    @usage.destroy
    redirect_to usages_url, notice: 'Usage was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_usage
      @usage = Usage.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def usage_params
      params.require(:usage).permit(:ip_used, :fqdn, :description, :section_id)
    end
end
