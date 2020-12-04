# -*- encoding: utf-8 -*-
# stub: grape-cancan 0.0.3 ruby lib

Gem::Specification.new do |s|
  s.name = "grape-cancan".freeze
  s.version = "0.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Ray Zane".freeze]
  s.date = "2019-07-05"
  s.description = "Authorize your Grape API with CanCan".freeze
  s.email = ["raymondzane@gmail.com".freeze]
  s.homepage = "https://github.com/rzane/grape-cancan".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.1.4".freeze
  s.summary = "Authorize your Grape API with CanCan".freeze

  s.installed_by_version = "3.1.4" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<grape>.freeze, ["~> 1.2"])
    s.add_runtime_dependency(%q<cancancan>.freeze, [">= 0"])
    s.add_development_dependency(%q<bundler>.freeze, ["~> 2.0"])
    s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
    s.add_development_dependency(%q<minitest>.freeze, ["~> 5.8.4"])
    s.add_development_dependency(%q<rack-test>.freeze, [">= 0"])
  else
    s.add_dependency(%q<grape>.freeze, ["~> 1.2"])
    s.add_dependency(%q<cancancan>.freeze, [">= 0"])
    s.add_dependency(%q<bundler>.freeze, ["~> 2.0"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
    s.add_dependency(%q<minitest>.freeze, ["~> 5.8.4"])
    s.add_dependency(%q<rack-test>.freeze, [">= 0"])
  end
end
