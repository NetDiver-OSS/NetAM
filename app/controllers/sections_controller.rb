class SectionsController < ApplicationController
  before_action :set_section, only: [:show, :scan, :edit, :update, :destroy, :export]
  before_action :authenticate_admin!

  # GET /sections
  def index
    @sections = Section.all
  end

  # GET /sections/1
  def show

    ip_used = @section.usages.where(state: 0..3).count
    ip_locked = @section.usages.where(state: 0).count
    ip_up = @section.usages.where(state: 1).count
    ip_down = @section.usages.where(state: 2).count
    ip_dhcp = @section.usages.where(state: 3).count
    ip_free = IPAddr.new(@section.network).to_range.count - ip_used

    Daru::View.plotting_library = :highcharts

    opts = {
        chart: {
            plotBackgroundColor: nil,
            plotBorderWidth: nil,
            plotShadow: false,
            type: 'pie'
        },
        title: {
            text: 'IP Usage'
        },
        tooltip: {
            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: true,
                    format: '<b>{point.name}</b>: {point.percentage:.1f} %',
                }
            }
        },
    }

    series_dt = [
        {
            name: 'IP',
            colorByPoint: true,
            data: [
                {
                    name: 'Locked',
                    y: ip_locked,
                    color: '#838383'
                },
                {
                    name: 'Up',
                    y: ip_up,
                    color: '#16ab39'
                },
                {
                    name: 'Down',
                    y: ip_down,
                    color: '#db2828'
                },
                {
                    name: 'Free',
                    y: ip_free,
                    color: '#2185d0',
                    sliced: true,
                    selected: true
                },
                {
                    name: 'DHCP',
                    y: ip_dhcp,
                    color: '#9627ba'
                }
            ]
        }
    ]

    @ip_usage_graph = Daru::View::Plot.new(series_dt, opts)
  end

  # POST /sections/1/scan
  def scan
    ScanNetworkWithPingJob.perform_later({ id: @section.id, network: @section.network })

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
        { :class => 'ScanNetworkWithPingJob', :every => section.schedule, :queue => 'default', :args => [{:id => section.id, :network => section.network}] }
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
