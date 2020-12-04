# -*- encoding: utf-8 -*-
# stub: redis-rack-cache 2.2.1 ruby lib

Gem::Specification.new do |s|
  s.name = "redis-rack-cache".freeze
  s.version = "2.2.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Luca Guidi".freeze]
  s.date = "2019-11-13"
  s.description = "A Redis backend store for Rack::Cache".freeze
  s.email = ["me@lucaguidi.com".freeze]
  s.homepage = "http://redis-store.org/redis-rack-cache".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.1.4".freeze
  s.summary = "A Redis backend store for Rack::Cache".freeze

  s.installed_by_version = "3.1.4" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<redis-store>.freeze, [">= 1.6", "< 2"])
    s.add_runtime_dependency(%q<rack-cache>.freeze, [">= 1.10", "< 2"])
    s.add_development_dependency(%q<rake>.freeze, ["~> 10"])
    s.add_development_dependency(%q<bundler>.freeze, ["> 1", "< 3"])
    s.add_development_dependency(%q<mocha>.freeze, ["~> 0.14.0"])
    s.add_development_dependency(%q<minitest>.freeze, ["~> 5.11.0"])
    s.add_development_dependency(%q<redis-store-testing>.freeze, ["~> 0"])
    s.add_development_dependency(%q<appraisal>.freeze, ["~> 2"])
  else
    s.add_dependency(%q<redis-store>.freeze, [">= 1.6", "< 2"])
    s.add_dependency(%q<rack-cache>.freeze, [">= 1.10", "< 2"])
    s.add_dependency(%q<rake>.freeze, ["~> 10"])
    s.add_dependency(%q<bundler>.freeze, ["> 1", "< 3"])
    s.add_dependency(%q<mocha>.freeze, ["~> 0.14.0"])
    s.add_dependency(%q<minitest>.freeze, ["~> 5.11.0"])
    s.add_dependency(%q<redis-store-testing>.freeze, ["~> 0"])
    s.add_dependency(%q<appraisal>.freeze, ["~> 2"])
  end
end
