# -*- encoding: utf-8 -*-
# stub: gettext_i18n_rails 1.8.1 ruby lib

Gem::Specification.new do |s|
  s.name = "gettext_i18n_rails".freeze
  s.version = "1.8.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Michael Grosser".freeze]
  s.date = "2019-12-10"
  s.email = "michael@grosser.it".freeze
  s.homepage = "http://github.com/grosser/gettext_i18n_rails".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.1.0".freeze)
  s.rubygems_version = "3.1.4".freeze
  s.summary = "Simple FastGettext Rails integration.".freeze

  s.installed_by_version = "3.1.4" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<fast_gettext>.freeze, [">= 0.9.0"])
    s.add_development_dependency(%q<bump>.freeze, [">= 0"])
    s.add_development_dependency(%q<gettext>.freeze, [">= 3.0.2"])
    s.add_development_dependency(%q<haml>.freeze, [">= 0"])
    s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    s.add_development_dependency(%q<rails>.freeze, [">= 0"])
    s.add_development_dependency(%q<ruby_parser>.freeze, [">= 3.7.1"])
    s.add_development_dependency(%q<sexp_processor>.freeze, [">= 0"])
    s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_development_dependency(%q<slim>.freeze, [">= 0"])
    s.add_development_dependency(%q<sqlite3>.freeze, [">= 0"])
    s.add_development_dependency(%q<wwtd>.freeze, [">= 0"])
  else
    s.add_dependency(%q<fast_gettext>.freeze, [">= 0.9.0"])
    s.add_dependency(%q<bump>.freeze, [">= 0"])
    s.add_dependency(%q<gettext>.freeze, [">= 3.0.2"])
    s.add_dependency(%q<haml>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<rails>.freeze, [">= 0"])
    s.add_dependency(%q<ruby_parser>.freeze, [">= 3.7.1"])
    s.add_dependency(%q<sexp_processor>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_dependency(%q<slim>.freeze, [">= 0"])
    s.add_dependency(%q<sqlite3>.freeze, [">= 0"])
    s.add_dependency(%q<wwtd>.freeze, [">= 0"])
  end
end
