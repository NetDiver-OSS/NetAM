# frozen_string_literal: true

require 'simplecov'
require 'simplecov-cobertura'
require 'active_support/core_ext/numeric/time'

module SimpleCovEnv
  module_function

  def start!
    configure_profile
    configure_formatter

    SimpleCov.start
  end

  def configure_formatter
    SimpleCov.formatters = SimpleCov::Formatter::MultiFormatter.new(
      [
        SimpleCov::Formatter::SimpleFormatter,
        SimpleCov::Formatter::HTMLFormatter,
        SimpleCov::Formatter::CoberturaFormatter
      ]
    )
  end

  def configure_profile
    SimpleCov.configure do
      load_profile 'test_frameworks'
      track_files '{app,lib}/**/*.rb'

      add_filter 'config/'
      add_filter 'lib/netam.rb'
      add_filter 'lib/backup.rb'
      add_filter 'lib/netam/section.rb'
      add_filter 'app/jobs/application_job.rb'
      add_filter 'app/controllers/setup_controller.rb'
      add_filter 'app/controllers/callbacks_controller.rb'

      add_group 'Controllers', 'app/controllers'
      add_group 'Helpers', 'app/helpers'
      add_group 'Libraries', '/lib'
      add_group 'Mailers', 'app/mailers'
      add_group 'Models', 'app/models'
      add_group 'Serializers', 'app/serializers'
      add_group 'Services', 'app/services'
      add_group 'Workers', ['app/jobs', 'app/workers']

      merge_timeout 365.days
    end
  end
end
