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
  def show; end

  # GET /usages/new
  def new
    @usage = @section.usages.build
  end

  # GET /usages/1/edit
  def edit; end

  # POST /usages/1/scan
  def scan
    @usage = Usage.find(params[:usage_id])

    ScanAddressWithPingJob.perform_later({ id: @usage.id, ip_used: @usage.ip_used, section_id: @usage.section_id, state: @usage.state })

    redirect_to section_path(@usage.section_id), notice: 'Scan was successfully scheduled.'
  end

  # POST /usages
  def create
    @usage = @section.usages.build(usage_params)

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

  def set_section
    @section = Section.find(params[:section_id])
  end

  def set_usage
    @usage = Usage.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def usage_params
    params.require(:usage).permit(:ip_used, :fqdn, :description, :state, :section_id)
  end
end
