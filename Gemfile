source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

# Rails framework
gem 'bootsnap', '>= 1.4.7', require: false
gem 'puma', '~> 5.0'
gem 'rails', '~> 6.0.2', '>= 6.0.2.1'

# Database
gem 'pg', '>= 0.18', '< 2.0'

# HTML
gem 'hamlit', '~> 2.11'
gem 'rqrcode', '~> 1.1', '>= 1.1.2'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 5.2.0'

# Rails Delayed Jobs
gem 'sidekiq', '~>6.1.1'
gem "sidekiq-cron", "~> 1.2"
gem "sidekiq-status", "~> 1.1"

gem 'redis', '~> 4.0'
gem 'redis-rack-cache'

# Authentification
gem 'cancancan', '~> 3.1'
gem 'devise', '~> 4.7', '>= 4.7.1'
gem 'devise-two-factor', '~> 3.1'
gem "doorkeeper", "~> 5.4"
gem 'omniauth-ldap', '~> 2.0'

# Jobs dependencies
gem 'ipaddress', '~> 0.8.3'
gem 'net-ping', '~> 2.0', '>= 2.0.6'
gem 'parallel', '~> 1.19', '>= 1.19.1'

# API
gem 'grape', '~> 1.4'
gem 'grape-active_model_serializers', '~> 1.5', '>= 1.5.2'
gem "grape-cancan", "~> 0.0.3"
gem 'grape_on_rails_routes', '~> 0.3.2'
gem 'grape-swagger', '~> 1.2'
gem 'grape-swagger-rails', '~> 0.3.1'

# Error notifier
gem 'sentry-raven', '~> 3.0'

gem 'vmstat', '~> 2.3', '>= 2.3.1'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]

  gem 'rspec_junit_formatter', '~> 0.4.1'
  gem "rspec-rails", "~> 4.0"
  gem 'simplecov', '= 0.17.1'
  gem 'simplecov-cobertura', '~> 1.3', '>= 1.3.1'

  gem 'rubocop', '~> 0.88.0'
  gem 'rubocop-performance', '~> 1.7'
  gem 'rubocop-rspec', '~> 1.42'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'better_errors', '~> 2.7', '>= 2.7.1'
  gem 'binding_of_caller', '~> 0.8.0'

  gem 'listen', '>= 3.0.5', '< 3.2'
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
