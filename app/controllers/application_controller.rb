# frozen_string_literal: true

class ApplicationController < ActionController::Base
  layout :layout_configuration

  before_action :set_gettext_locale
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

  def index
    @main_node = {
      cpu: Vmstat.cpu,
      memory: Vmstat.memory,
      load_average: Vmstat.load_average,
      boot_time: Vmstat.boot_time
    }

    @sidekiq_processes = Sidekiq::ProcessSet.new(false).map do |process|
      {
        worker: Worker.find_by(uuid: process['queues'].first.gsub('node:', ''))&.name,
        hostname: process['hostname'],
        started_at: Time.zone.at(process['started_at']),
        concurrency: process['concurrency'],
        busy: process['busy'],
        queues: process['queues'],
        beat: Time.zone.at(process['beat'])
      }
    end
  end

  protected

  def after_sign_in_path_for(resource)
    cookies[:token] = {
      value: Doorkeeper::AccessToken.create!(resource_owner_id: current_user.id, expires_in: 24.hours).plaintext_token,
      expires: 24.hours.from_now
    }

    stored_location_for(resource) || root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in, keys: [:otp_attempt])
  end

  private

  def layout_configuration
    if devise_controller?
      controller_name == 'registrations' && action_name == 'edit' ? 'application' : 'devise'
    else
      'application'
    end
  end
end
