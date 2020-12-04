# -*- encoding: utf-8 -*-
# stub: sentry-raven 3.1.1 ruby lib

Gem::Specification.new do |s|
  s.name = "sentry-raven".freeze
  s.version = "3.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Sentry Team".freeze]
  s.bindir = "exe".freeze
  s.date = "2020-09-24"
  s.description = "A gem that provides a client interface for the Sentry error logger".freeze
  s.email = "accounts@sentry.io".freeze
  s.executables = ["raven".freeze]
  s.extra_rdoc_files = ["README.md".freeze, "LICENSE".freeze]
  s.files = ["LICENSE".freeze, "README.md".freeze, "exe/raven".freeze]
  s.homepage = "https://github.com/getsentry/raven-ruby".freeze
  s.licenses = ["Apache-2.0".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.3".freeze)
  s.rubygems_version = "3.1.4".freeze
  s.summary = "A gem that provides a client interface for the Sentry error logger".freeze

  s.installed_by_version = "3.1.4" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<faraday>.freeze, [">= 1.0"])
  else
    s.add_dependency(%q<faraday>.freeze, [">= 1.0"])
  end
end
