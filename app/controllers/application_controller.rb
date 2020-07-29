class ApplicationController < ActionController::Base
  before_action :setup_required
  before_action :authenticate_user!
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

  def index
    @cpus = begin
              Vmstat.cpu
            rescue StandardError
              nil
            end
    @memory = begin
                Vmstat.memory
              rescue StandardError
                nil
              end
    @load_average = begin
                      Vmstat.load_average
                    rescue StandardError
                      nil
                    end
    @boot_time = begin
                   Vmstat.boot_time
                 rescue StandardError
                   nil
                 end
  end

  private

  def authenticate_user!
    super unless ['setup'].include?(params[:controller])
  end

  def setup_required
    redirect_to install_path if Rails.application.config.setup_mode && params[:controller] != 'setup'
  end
end
