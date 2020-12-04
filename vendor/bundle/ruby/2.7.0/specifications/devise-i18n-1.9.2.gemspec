# -*- encoding: utf-8 -*-
# stub: devise-i18n 1.9.2 ruby lib

Gem::Specification.new do |s|
  s.name = "devise-i18n".freeze
  s.version = "1.9.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Christopher Dell".freeze, "mcasimir".freeze, "Jason Barnabe".freeze]
  s.date = "2020-08-24"
  s.description = "Translations for the devise gem".freeze
  s.email = "chris@tigrish.com".freeze
  s.extra_rdoc_files = ["LICENSE.txt".freeze, "README.md".freeze]
  s.files = ["LICENSE.txt".freeze, "README.md".freeze]
  s.homepage = "http://github.com/tigrish/devise-i18n".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.1.4".freeze
  s.summary = "Translations for the devise gem".freeze

  s.installed_by_version = "3.1.4" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<devise>.freeze, [">= 4.7.1"])
    s.add_development_dependency(%q<rspec>.freeze, [">= 2.8.0"])
    s.add_development_dependency(%q<rspec-rails>.freeze, [">= 0"])
    s.add_development_dependency(%q<bundler>.freeze, ["~> 1.2"])
    s.add_development_dependency(%q<jeweler>.freeze, [">= 0"])
    s.add_development_dependency(%q<i18n-spec>.freeze, ["~> 0.6.0"])
    s.add_development_dependency(%q<localeapp>.freeze, [">= 0"])
    s.add_development_dependency(%q<railties>.freeze, [">= 0"])
    s.add_development_dependency(%q<activemodel>.freeze, [">= 0"])
  else
    s.add_dependency(%q<devise>.freeze, [">= 4.7.1"])
    s.add_dependency(%q<rspec>.freeze, [">= 2.8.0"])
    s.add_dependency(%q<rspec-rails>.freeze, [">= 0"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.2"])
    s.add_dependency(%q<jeweler>.freeze, [">= 0"])
    s.add_dependency(%q<i18n-spec>.freeze, ["~> 0.6.0"])
    s.add_dependency(%q<localeapp>.freeze, [">= 0"])
    s.add_dependency(%q<railties>.freeze, [">= 0"])
    s.add_dependency(%q<activemodel>.freeze, [">= 0"])
  end
end
