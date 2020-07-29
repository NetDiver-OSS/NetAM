require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Netam
  class Application < Rails::Application
    require_dependency Rails.root.join('lib/netam')

    config.active_job.queue_name_prefix = Rails.env
    config.active_job.queue_name_delimiter = '.'

    config.paths.add File.join('app', 'api'), glob: File.join('**', '*.rb')
    config.autoload_paths += Dir[Rails.root.join('app', 'api', '*')]

    # Load custom configuration file
    config.netam = config_for(:netam)

    config.load_defaults 6.0
    config.active_job.queue_adapter = :sidekiq

    config.assets.enabled = true
    config.assets.paths << "#{Rails.root}/app/assets/fonts"
    config.assets.paths << "#{Rails.root}/app/assets/stylesheets"

    # Autoload lib/ folder including all subdirectories
    config.eager_load_paths << Rails.root.join('lib')

    config.action_view.field_error_proc = Proc.new do |html_tag, _|
      html_tag.html_safe
    end
  end
end
