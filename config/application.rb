require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Netam
  class Application < Rails::Application
    config.load_defaults 6.0
    config.active_job.queue_adapter = :sidekiq

    config.assets.enabled = true
    config.assets.paths << "#{Rails.root}/app/assets/fonts"
    config.assets.paths << "#{Rails.root}/app/assets/stylesheets"

    # Autoload lib/ folder including all subdirectories
    config.eager_load_paths << Rails.root.join('lib')

    config.action_view.field_error_proc = Proc.new do |html_tag, instance|
      html_tag.html_safe
    end

  end
end
