# -*- encoding: utf-8 -*-
# stub: logstash-event 1.2.02 ruby lib

Gem::Specification.new do |s|
  s.name = "logstash-event".freeze
  s.version = "1.2.02"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Jordan Sissel".freeze]
  s.date = "2013-09-11"
  s.description = "Library that contains the classes required to create LogStash events".freeze
  s.email = ["jls@semicomplete.com".freeze]
  s.homepage = "https://github.com/logstash/logstash".freeze
  s.licenses = ["Apache License (2.0)".freeze]
  s.rubygems_version = "3.1.4".freeze
  s.summary = "Library that contains the classes required to create LogStash events".freeze

  s.installed_by_version = "3.1.4" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_development_dependency(%q<guard>.freeze, [">= 0"])
    s.add_development_dependency(%q<guard-rspec>.freeze, [">= 0"])
    s.add_development_dependency(%q<insist>.freeze, ["= 1.0.0"])
  else
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_dependency(%q<guard>.freeze, [">= 0"])
    s.add_dependency(%q<guard-rspec>.freeze, [">= 0"])
    s.add_dependency(%q<insist>.freeze, ["= 1.0.0"])
  end
end
