# -*- encoding: utf-8 -*-
# stub: grape_on_rails_routes 0.3.2 ruby lib

Gem::Specification.new do |s|
  s.name = "grape_on_rails_routes".freeze
  s.version = "0.3.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["syedmusamah".freeze]
  s.date = "2017-05-27"
  s.description = "View routes for all Grape API's mounted on Rails".freeze
  s.email = ["syed@thredup.com".freeze]
  s.homepage = "https://github.com/syedmusamah/grape_on_rails_routes".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.1.4".freeze
  s.summary = "Grape API routes".freeze

  s.installed_by_version = "3.1.4" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<rails>.freeze, [">= 3.1.1"])
    s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_development_dependency(%q<grape>.freeze, [">= 0"])
  else
    s.add_dependency(%q<rails>.freeze, [">= 3.1.1"])
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_dependency(%q<grape>.freeze, [">= 0"])
  end
end
