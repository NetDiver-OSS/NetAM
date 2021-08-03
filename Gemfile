# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Rails framework
gem 'bootsnap', '>= 1.4.7', require: false
gem 'puma', '5.4.0'
gem 'rails', '6.1.4'

# Database
gem 'ledermann-rails-settings', '~> 2.5'
gem 'pg', '>= 0.18', '< 2.0'

# HTML
gem 'hamlit', '~> 2.15'
gem 'kaminari', '~> 1.2', '>= 1.2.1'
gem 'rqrcode', '~> 2.0'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 5.4.0'

# Search engine
gem 'typesense', '0.12.0'

# I18n
gem 'gettext', '~> 3.3', require: false, group: :development
gem 'gettext_i18n_rails', '~> 1.8.1'
gem 'gettext_i18n_rails_js', '~> 1.3'
gem 'rails-i18n', '~> 6.0'
gem 'ruby_parser', '~> 3.16', require: false

# Rails Delayed Jobs
gem 'sidekiq', '6.2.1'
gem 'sidekiq-cron', '= 1.2'
gem 'sidekiq-status', '2.0.2'

gem 'redis', '~> 4.3'
gem 'redis-rack-cache'

# Authentification
gem 'cancancan', '~> 3.3'
gem 'devise', '~> 4.8'
gem 'devise-i18n', '~> 1.10'
gem 'devise-two-factor', '~> 4.0'
gem 'doorkeeper', '~> 5.5'
gem 'omniauth-ldap', '~> 2.0'

# Jobs dependencies
gem 'ipaddress', '~> 0.8.3'
gem 'net-ping', '~> 2.0', '>= 2.0.6'
gem 'parallel', '~> 1.20'
gem 'whois-parser', '~> 1.2'

# API
gem 'grape', '~> 1.5'
gem 'grape-active_model_serializers', '~> 1.5', '>= 1.5.2'
gem 'grape-cancan', '~> 0.0.3'
gem 'grape_on_rails_routes', '~> 0.3.2'
gem 'grape-swagger', '~> 1.4'
gem 'grape-swagger-rails', '~> 0.3.1'

# Error notifier
gem 'sentry-rails', '4.6.4'
gem 'sentry-ruby', '4.6.4'
gem 'sentry-sidekiq', '4.6.4'

# Logs management
gem 'amazing_print', '1.3.0'
gem 'rails_semantic_logger', '4.6.0'

gem 'logstash-logger', '= 0.26.1'
gem 'net_tcp_client', '= 2.2'
gem 'syslog_protocol', '= 0.9.2'

gem 'vmstat', '~> 2.3', '>= 2.3.1'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]

  gem 'rspec_junit_formatter', '~> 0.4.1'
  gem 'rspec-rails', '~> 5.0'
  # Don't upgrade simplecov due to bug in sonarcloud !
  gem 'simplecov', '0.21.2'

  gem 'factory_bot_rails', '~> 6.2'

  gem 'rubocop', '1.16.1'
  gem 'rubocop-performance', '~> 1.11'
  gem 'rubocop-rails', '~> 2.11'
  gem 'rubocop-rspec', '~> 2.4'

  gem 'haml_lint', '~> 0.37.1', require: false
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'better_errors', '2.9.1'
  gem 'binding_of_caller', '~> 1.0.0'

  gem 'listen', '3.6.0'
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
