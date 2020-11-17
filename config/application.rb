# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module NetAM
  class Application < Rails::Application
    require_dependency Rails.root.join('lib/netam')
    require_dependency Rails.root.join('lib/netam/translation')

    config.paths.add File.join('app', 'api'), glob: File.join('**', '*.rb')
    config.autoload_paths += Dir[Rails.root.join('app/api/*')]

    # Load custom configuration file
    config.netam = config_for(:netam)

    config.load_defaults 6.0
    config.active_job.queue_adapter = :sidekiq

    config.assets.enabled = true
    config.assets.paths << Rails.root.join('app/assets/fonts')
    config.assets.paths << Rails.root.join('app/assets/stylesheets')

    # Autoload lib/ folder including all subdirectories
    config.eager_load_paths << Rails.root.join('lib')

    config.i18n.enforce_available_locales = false
    config.i18n.fallbacks = FastGettext.default_locale

    config.action_view.field_error_proc = proc do |html_tag, _|
      html_tag.html_safe # rubocop:disable Rails/OutputSafety
    end
  end
end
