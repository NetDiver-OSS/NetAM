class SectionsController < ApplicationController
  before_action :set_section, only: [:show, :scan, :edit, :update, :destroy, :export]
  before_action :authenticate_admin!

  # GET /sections
  def index
    @sections = Section.all
  end

  # GET /sections/1
  def show
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
                    style: {
                        color: "(Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'".js_code
                    }
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
                    name: 'Used',
                    y: 42
                },
                {
                    name: 'Reserved',
                    y: 8
                },
                {
                    name: 'Fixed',
                    y: 10
                },
                {
                    name: 'Free',
                    y: 196
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
    ExportSectionToCsv.perform_later(@section)
    redirect_to sections_url, notice: 'Scan was successfully scheduled.'
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
