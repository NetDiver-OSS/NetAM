# -*- encoding: utf-8 -*-
# stub: syslog_protocol 0.9.2 ruby lib

Gem::Specification.new do |s|
  s.name = "syslog_protocol".freeze
  s.version = "0.9.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Jake Douglas".freeze, "Eric Lindvall".freeze]
  s.date = "2009-08-01"
  s.description = "Syslog protocol parser and generator".freeze
  s.email = ["jakecdouglas@gmail.com".freeze, "eric@5stops.com".freeze]
  s.extra_rdoc_files = ["README.md".freeze]
  s.files = ["README.md".freeze]
  s.homepage = "https://github.com/eric/syslog_protocol".freeze
  s.rdoc_options = ["--charset=UTF-8".freeze]
  s.rubygems_version = "3.1.4".freeze
  s.summary = "Syslog protocol parser and generator".freeze

  s.installed_by_version = "3.1.4" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 2
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<bacon>.freeze, ["~> 1.1.0"])
  else
    s.add_dependency(%q<bacon>.freeze, ["~> 1.1.0"])
  end
end
