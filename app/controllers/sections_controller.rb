class SectionsController < ApplicationController
  before_action :set_section, only: %i[show scan export edit update destroy]
  before_action :authenticate_user!

  include SectionsHelper

  # GET /sections
  def index
    @sections = Section.all
  end

  # GET /sections/1
  def show
    ip_used = @section.usages.where(state: 0..3).count

    @ip_usage_graph = [
        {
            title: 'Locked',
            value: @section.usages.where(state: 0).count,
            color: '#838383'
        },
        {
            title: 'Up',
            value: @section.usages.where(state: 1).count,
            color: '#16ab39'
        },
        {
            title: 'Down',
            value: @section.usages.where(state: 2).count,
            color: '#db2828'
        },
        {
            title: 'Free',
            value: IPAddress(@section.network).size - ip_used,
            color: '#2185d0'
        },
        {
            title: 'DHCP',
            value: @section.usages.where(state: 3).count,
            color: '#9627ba'
        }
    ]
  end

  # POST /sections/1/scan
  def scan
    ScanNetworkWithPingJob.perform_later({id: @section.id, network: @section.network})

    redirect_to sections_url, notice: 'Scan was successfully scheduled.'
  end

  # GET /sections/new
  def new
    @section = Section.new
  end

  # GET /sections/1/edit
  def edit
  end

  # POST /sections
  def create
    @section = Section.new(section_params)

    if @section.save
      update_scheduler @section
      redirect_to @section, notice: 'Section was successfully created.'
    else
      render :new
    end

  end

  # PATCH/PUT /sections/1
  def update
    if @section.update(section_params)
      update_scheduler @section
      redirect_to @section, notice: 'Section was successfully updated.'
    else
      render :edit
    end
  end


  # DELETE /sections/1
  def destroy
    Sidekiq.remove_schedule("schedule:#{@section.id}")
    @section.destroy
    redirect_to sections_url, notice: 'Section was successfully destroyed.'
  end

  def export
    csvExport = ExportSectionToCsvJob.perform_now(@section)
    send_data csvExport, filename: "section_usage_#{@section.id}.csv", type: 'text/csv', disposition: 'inline'
  end

  private

  def update_scheduler(section)
    schedule_name = "schedule:#{section.id}"

    Sidekiq.remove_schedule(schedule_name) unless Sidekiq.get_schedule(schedule_name).nil?

    Sidekiq.set_schedule(
        schedule_name,
        {:class => 'ScanNetworkWithPingJob', :every => [section.schedule, first_in: '0s'], :queue => 'default', :args => [{:id => section.id, :network => section.network}]}
    )
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_section
    @section = Section.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def section_params
    params.require(:section).permit(:name, :description, :network, :schedule)
  end

end
