# -*- encoding: utf-8 -*-
# stub: amazing_print 1.2.2 ruby lib

Gem::Specification.new do |s|
  s.name = "amazing_print".freeze
  s.version = "1.2.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Michael Dvorkin".freeze, "Kevin McCormackPatrik Wenger".freeze]
  s.date = "2020-10-12"
  s.description = "Great Ruby debugging companion: pretty print Ruby objects to visualize their structure. Supports custom object formatting via plugins".freeze
  s.email = "harlemsquirrel@gmail.com".freeze
  s.homepage = "https://github.com/amazing-print/amazing_print".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.5.0".freeze)
  s.rubygems_version = "3.1.4".freeze
  s.summary = "Pretty print Ruby objects with proper indentation and colors".freeze

  s.installed_by_version = "3.1.4" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<appraisal>.freeze, ["~> 2.3"])
    s.add_development_dependency(%q<fakefs>.freeze, ["~> 1.2"])
    s.add_development_dependency(%q<nokogiri>.freeze, ["~> 1.10"])
    s.add_development_dependency(%q<pry>.freeze, [">= 0"])
    s.add_development_dependency(%q<rspec>.freeze, ["~> 3.9"])
    s.add_development_dependency(%q<rubocop>.freeze, ["~> 0.81.0"])
  else
    s.add_dependency(%q<appraisal>.freeze, ["~> 2.3"])
    s.add_dependency(%q<fakefs>.freeze, ["~> 1.2"])
    s.add_dependency(%q<nokogiri>.freeze, ["~> 1.10"])
    s.add_dependency(%q<pry>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.9"])
    s.add_dependency(%q<rubocop>.freeze, ["~> 0.81.0"])
  end
end
