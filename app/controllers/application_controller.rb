class ApplicationController < ActionController::Base
  before_action :set_gettext_locale
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :setup_required
  before_action :authenticate_user
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

  def index
    @master_node = {
      cpu: Vmstat.cpu,
      memory: Vmstat.memory,
      load_average: Vmstat.load_average,
      boot_time: Vmstat.boot_time
    }

    @sidekiq_queues = Sidekiq::Queue.all.map do |queue|
      {
        name: queue.name,
        backlog: queue.size,
        latency: queue.latency.to_i
      }
    end

    @sidekiq_processes = Sidekiq::ProcessSet.new(false).map do |process|
      {
        hostname: process['hostname'],
        started_at: Time.at(process['started_at']),
        concurrency: process['concurrency'],
        busy: process['busy'],
        queues: process['queues'],
        beat: Time.at(process['beat'])
      }
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in, keys: [:otp_attempt])
  end

  private

  def authenticate_user
    authenticate_user! unless params[:controller] == 'setup'
  end

  def setup_required
    redirect_to install_path if Rails.application.config.setup_mode && params[:controller] != 'setup'
  end
end
