class SectionsController < ApplicationController
  load_and_authorize_resource
  before_action :set_permissions, only: [:edit]
  before_action :set_vlan, only: %i[new create edit]

  # GET /sections
  def index
    @sections = Section.all.filter { |section| can? :read, section }
  end

  # GET /sections/1
  def show
    @all_ip_used = IPAddress(@section.network).ipv4? && IPAddress(@section.network).prefix >= 24 ? Usage.where(section_id: params[:id]).pluck(:id, :ip_used, :state) : []

    @ip_locked = @section.usages.locked.count
    @ip_activated = @section.usages.actived.count
    @ip_down = @section.usages.down.count
    @ip_dhcp = @section.usages.dhcp.count

    @ip_free = IPAddress(@section.network).size - @section.usages.where(state: 0..3).count

    @chart_label = "[\"#{_('Locked')}\", \"#{_('Activated')}\", \"#{_('Down')}\", \"#{_('Free IP')}\", \"#{_('DHCP')}\"]".html_safe
    @chart_data = [@ip_locked, @ip_activated, @ip_down, @ip_free, @ip_dhcp]
    @chart_color = '["#2185d0", "#16ab39", "#db2828", "#838383", "#9627ba"]'.html_safe
  end

  # POST /sections/1/scan
  def scan
    @section = Section.find(params[:section_id])

    job_id = NetAM::Scanner.new('ScanNetworkWithPingJob').run(@section.id, @section.network)

    redirect_to section_path(@section, scan_id: job_id), notice: 'Scan was successfully scheduled.'
  end

  # GET /sections/new
  def new
    @section = Section.new
  end

  # GET /sections/1/edit
  def edit
    # not used actually
  end

  # POST /sections
  def create
    @section = Section.new(section_params)

    if @section.save
      Permission.create!(
        {
          user_id: current_user.id,
          subject_class: 'Section',
          subject_id: @section.id,
          action: 'manage'
        }
      )

      job_id = NetAM::Scanner.new('ScanNetworkWithPingJob').run(@section.id, @section.network) if @section.run_scan == '1'
      @section.settings(:notification).update!(on_run: @section.notification_run_scan == '1')

      redirect_to section_path(@section, scan_id: job_id), notice: 'Scan was successfully scheduled.'
    else
      render :new
    end
  end

  # PATCH/PUT /sections/1
  def update
    if @section.update(section_params)
      @section.settings(:notification).update!(on_run: @section.notification_run_scan == '1')
      redirect_to @section, notice: 'Section was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /sections/1
  def destroy
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

  def set_vlan
    @vlan_list = Vlan.all.order(:vid).filter { |vlan| can? :read, vlan }.pluck(:name, :id)
  end

  # Only allow a list of trusted parameters through.
  def section_params
    params.require(:section).permit(:name, :description, :network, :schedule, :vlan_id, :run_scan, :notification_run_scan)
  end
end
