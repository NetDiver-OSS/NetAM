class SectionsController < ApplicationController
  load_and_authorize_resource
  before_action :set_permissions, only: [:edit]

  include SectionsHelper

  # GET /sections
  def index
    @sections = Section.all
  end

  # GET /sections/1
  def show
    @all_ip_used = Usage.where(section_id: params[:id]).pluck(:id, :ip_used, :state)

    @ip_locked = @section.usages.where(state: 0).count
    @ip_activated = @section.usages.where(state: 1).count
    @ip_down = @section.usages.where(state: 2).count
    @ip_dhcp = @section.usages.where(state: 3).count

    @ip_free = IPAddress(@section.network).size - @section.usages.where(state: 0..3).count

    @chart_label = '["Locked", "Up", "Down", "Free", "DHCP"]'.html_safe
    @chart_data = [@ip_locked, @ip_activated, @ip_down, @ip_free, @ip_dhcp]
    @chart_color = '["#838383", "#16ab39", "#db2828", "#2185d0", "#9627ba"]'.html_safe
  end

  # POST /sections/1/scan
  def scan
    @section = Section.find(params[:section_id])

    ScanNetworkWithPingJob.perform_later({ id: @section, network: @section.network })

    redirect_to sections_url, notice: 'Scan was successfully scheduled.'
  end

  # GET /sections/new
  def new
    @section = Section.new
  end

  # GET /sections/1/edit
  def edit; end

  # POST /sections
  def create
    @section = Section.new(section_params)

    if @section.save
      update_scheduler @section
      Permission.create!(
        {
          user_id: current_user.id,
          subject_class: 'Section',
          subject_id: @section.id,
          action: 'manage'
        }
      )

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
    @section = Section.find(params[:section_id])

    csv_export = ExportSectionToCsvJob.perform_now(@section)
    send_data csv_export, filename: "section_usage_#{@section.id}.csv", type: 'text/csv', disposition: 'inline'
  end

  private

  def set_permissions
    @permissions = Permission.where(subject_class: 'Section', subject_id: @section.id)
  end

  def update_scheduler(section)
    schedule_name = "schedule:#{section.id}"

    Sidekiq.remove_schedule(schedule_name) unless Sidekiq.get_schedule(schedule_name).nil?

    Sidekiq.set_schedule(
      schedule_name,
      { class: 'ScanNetworkWithPingJob', every: [section.schedule, first_in: '0s'], queue: 'default', args: [{ id: section.id, network: section.network }] }
    )
  end

  # Only allow a list of trusted parameters through.
  def section_params
    params.require(:section).permit(:name, :description, :network, :schedule)
  end
end
