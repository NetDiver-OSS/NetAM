# frozen_string_literal: true

require 'simplecov'
require 'simplecov-cobertura'
require 'active_support/core_ext/numeric/time'

module SimpleCovEnv
  module_function

  def start!
    configure_profile
    configure_job
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

  def configure_job
    SimpleCov.configure do
      if ENV['CI']
        SimpleCov.at_exit do
          # In CI environment don't generate formatted reports
          # Only generate .resultset.json
          SimpleCov.result
        end
      end
    end
  end

  def configure_profile
    SimpleCov.configure do
      load_profile 'test_frameworks'
      track_files '{app,lib}/**/*.rb'

      add_filter 'config/'
      add_filter 'lib/netam.rb'

      add_group 'Controllers', 'app/controllers'
      add_group 'Helpers', 'app/helpers'
      add_group 'Mailers', 'app/mailers'
      add_group 'Models', 'app/models'
      add_group 'Serializers', 'app/serializers'
      add_group 'Workers', 'app/jobs'
      add_group 'Libraries', '/lib'

      merge_timeout 365.days
    end
  end
end
