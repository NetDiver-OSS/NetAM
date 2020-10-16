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
    @cpus = Vmstat.cpu rescue nil
    @memory = Vmstat.memory rescue nil
    @load_average = Vmstat.load_average rescue nil
    @boot_time = Vmstat.boot_time rescue nil
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
