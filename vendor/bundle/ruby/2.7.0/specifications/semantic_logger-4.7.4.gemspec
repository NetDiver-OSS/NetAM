# -*- encoding: utf-8 -*-
# stub: semantic_logger 4.7.4 ruby lib

Gem::Specification.new do |s|
  s.name = "semantic_logger".freeze
  s.version = "4.7.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Reid Morrison".freeze]
  s.date = "2020-11-21"
  s.email = ["reidmo@gmail.com".freeze]
  s.homepage = "https://github.com/rocketjob/semantic_logger".freeze
  s.licenses = ["Apache-2.0".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.3".freeze)
  s.rubygems_version = "3.1.4".freeze
  s.summary = "Feature rich logging framework, and replacement for existing Ruby & Rails loggers.".freeze

  s.installed_by_version = "3.1.4" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<concurrent-ruby>.freeze, ["~> 1.0"])
  else
    s.add_dependency(%q<concurrent-ruby>.freeze, ["~> 1.0"])
  end
end
