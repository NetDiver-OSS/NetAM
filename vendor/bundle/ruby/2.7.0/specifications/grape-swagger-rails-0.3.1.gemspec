# -*- encoding: utf-8 -*-
# stub: grape-swagger-rails 0.3.1 ruby lib

Gem::Specification.new do |s|
  s.name = "grape-swagger-rails".freeze
  s.version = "0.3.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Alexander Logunov".freeze]
  s.date = "2019-02-16"
  s.description = "Swagger UI as Rails Engine for grape-swagger gem".freeze
  s.email = ["unlovedru@gmail.com".freeze]
  s.homepage = "https://github.com/ruby-grape/grape-swagger-rails".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.1.4".freeze
  s.summary = "Swagger UI as Rails Engine for grape-swagger gem".freeze

  s.installed_by_version = "3.1.4" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<railties>.freeze, [">= 3.2.12"])
    s.add_development_dependency(%q<bundler>.freeze, ["~> 1.15"])
    s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    s.add_development_dependency(%q<git>.freeze, [">= 0"])
    s.add_development_dependency(%q<rspec-rails>.freeze, [">= 0"])
    s.add_development_dependency(%q<capybara>.freeze, [">= 0"])
    s.add_development_dependency(%q<grape>.freeze, [">= 0"])
    s.add_development_dependency(%q<grape-swagger>.freeze, [">= 0.7.2"])
    s.add_development_dependency(%q<selenium-webdriver>.freeze, [">= 0"])
    s.add_development_dependency(%q<sass-rails>.freeze, [">= 0"])
    s.add_development_dependency(%q<uglifier>.freeze, [">= 0"])
    s.add_development_dependency(%q<coffee-rails>.freeze, [">= 0"])
    s.add_development_dependency(%q<jquery-rails>.freeze, [">= 0"])
    s.add_development_dependency(%q<grape-swagger-ui>.freeze, [">= 0"])
    s.add_development_dependency(%q<sprockets>.freeze, [">= 0"])
    s.add_development_dependency(%q<rack>.freeze, ["~> 1.6"])
    s.add_development_dependency(%q<rack-cors>.freeze, [">= 0"])
    s.add_development_dependency(%q<rubocop>.freeze, ["= 0.38.0"])
    s.add_development_dependency(%q<mime-types>.freeze, ["< 3.0"])
    s.add_development_dependency(%q<rack-no_animations>.freeze, [">= 0"])
    s.add_development_dependency(%q<nokogiri>.freeze, ["< 1.7.0"])
  else
    s.add_dependency(%q<railties>.freeze, [">= 3.2.12"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.15"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<git>.freeze, [">= 0"])
    s.add_dependency(%q<rspec-rails>.freeze, [">= 0"])
    s.add_dependency(%q<capybara>.freeze, [">= 0"])
    s.add_dependency(%q<grape>.freeze, [">= 0"])
    s.add_dependency(%q<grape-swagger>.freeze, [">= 0.7.2"])
    s.add_dependency(%q<selenium-webdriver>.freeze, [">= 0"])
    s.add_dependency(%q<sass-rails>.freeze, [">= 0"])
    s.add_dependency(%q<uglifier>.freeze, [">= 0"])
    s.add_dependency(%q<coffee-rails>.freeze, [">= 0"])
    s.add_dependency(%q<jquery-rails>.freeze, [">= 0"])
    s.add_dependency(%q<grape-swagger-ui>.freeze, [">= 0"])
    s.add_dependency(%q<sprockets>.freeze, [">= 0"])
    s.add_dependency(%q<rack>.freeze, ["~> 1.6"])
    s.add_dependency(%q<rack-cors>.freeze, [">= 0"])
    s.add_dependency(%q<rubocop>.freeze, ["= 0.38.0"])
    s.add_dependency(%q<mime-types>.freeze, ["< 3.0"])
    s.add_dependency(%q<rack-no_animations>.freeze, [">= 0"])
    s.add_dependency(%q<nokogiri>.freeze, ["< 1.7.0"])
  end
end
