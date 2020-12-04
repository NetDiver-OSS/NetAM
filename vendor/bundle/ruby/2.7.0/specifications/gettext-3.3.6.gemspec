# -*- encoding: utf-8 -*-
# stub: gettext 3.3.6 ruby lib

Gem::Specification.new do |s|
  s.name = "gettext".freeze
  s.version = "3.3.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Kouhei Sutou".freeze, "Masao Mutoh".freeze]
  s.date = "2020-08-03"
  s.description = "Gettext is a GNU gettext-like program for Ruby.\nThe catalog file(po-file) is same format with GNU gettext.\nSo you can use GNU gettext tools for maintaining.\n".freeze
  s.email = ["kou@clear-code.com".freeze, "mutomasa at gmail.com".freeze]
  s.executables = ["rmsgcat".freeze, "rmsgfmt".freeze, "rmsginit".freeze, "rmsgmerge".freeze, "rxgettext".freeze]
  s.files = ["bin/rmsgcat".freeze, "bin/rmsgfmt".freeze, "bin/rmsginit".freeze, "bin/rmsgmerge".freeze, "bin/rxgettext".freeze]
  s.homepage = "https://ruby-gettext.github.io/".freeze
  s.licenses = ["Ruby or LGPLv3+".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.5.0".freeze)
  s.rubygems_version = "3.1.4".freeze
  s.summary = "Gettext is a pure Ruby libary and tools to localize messages.".freeze

  s.installed_by_version = "3.1.4" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<locale>.freeze, [">= 2.0.5"])
    s.add_runtime_dependency(%q<text>.freeze, [">= 1.3.0"])
    s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    s.add_development_dependency(%q<racc>.freeze, [">= 0"])
    s.add_development_dependency(%q<yard>.freeze, [">= 0"])
    s.add_development_dependency(%q<kramdown>.freeze, [">= 0"])
    s.add_development_dependency(%q<test-unit>.freeze, [">= 0"])
    s.add_development_dependency(%q<test-unit-rr>.freeze, [">= 0"])
  else
    s.add_dependency(%q<locale>.freeze, [">= 2.0.5"])
    s.add_dependency(%q<text>.freeze, [">= 1.3.0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<racc>.freeze, [">= 0"])
    s.add_dependency(%q<yard>.freeze, [">= 0"])
    s.add_dependency(%q<kramdown>.freeze, [">= 0"])
    s.add_dependency(%q<test-unit>.freeze, [">= 0"])
    s.add_dependency(%q<test-unit-rr>.freeze, [">= 0"])
  end
end
