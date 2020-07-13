class UsagesController < ApplicationController
  before_action :set_usage, only: [:show, :scan, :edit, :update, :destroy]
  before_action :set_section_form, only: [:new, :edit]
  before_action :authenticate_user!

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

  # POST /usages/1/scan
  def scan
    ScanAddressWithPingJob.perform_later({ id: @usage.id, ip_used: @usage.ip_used, section_id: @usage.section_id, state: @usage.state })

    redirect_to section_path(@usage.section_id), notice: 'Scan was successfully scheduled.'
  end

  # POST /usages
  def create
    @usage = Usage.new(usage_params)

    if @usage.save
      redirect_to section_path(@usage.section_id), notice: 'Usage was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /usages/1
  def update
    if @usage.update(usage_params)
      redirect_to section_path(@usage.section_id), notice: 'Usage was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /usages/1
  def destroy
    @usage.destroy
    redirect_to section_path(@usage.section_id), notice: 'Usage was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_usage
      @usage = Usage.find(params[:id])
    end

  def set_section_form
    @sections = Section.all.pluck(:name, :id)
  end

    # Only allow a trusted parameter "white list" through.
    def usage_params
      params.require(:usage).permit(:ip_used, :fqdn, :description, :state, :section_id)
    end
end
