# -*- encoding: utf-8 -*-
# stub: hamlit 2.13.0 ruby lib
# stub: ext/hamlit/extconf.rb

Gem::Specification.new do |s|
  s.name = "hamlit".freeze
  s.version = "2.13.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Takashi Kokubun".freeze]
  s.bindir = "exe".freeze
  s.date = "2020-10-02"
  s.description = "High Performance Haml Implementation".freeze
  s.email = ["takashikkbn@gmail.com".freeze]
  s.executables = ["hamlit".freeze]
  s.extensions = ["ext/hamlit/extconf.rb".freeze]
  s.files = ["exe/hamlit".freeze, "ext/hamlit/extconf.rb".freeze]
  s.homepage = "https://github.com/k0kubun/hamlit".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.1.0".freeze)
  s.rubygems_version = "3.1.4".freeze
  s.summary = "High Performance Haml Implementation".freeze

  s.installed_by_version = "3.1.4" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<temple>.freeze, [">= 0.8.2"])
    s.add_runtime_dependency(%q<thor>.freeze, [">= 0"])
    s.add_runtime_dependency(%q<tilt>.freeze, [">= 0"])
    s.add_development_dependency(%q<benchmark_driver>.freeze, [">= 0"])
    s.add_development_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_development_dependency(%q<coffee-script>.freeze, [">= 0"])
    s.add_development_dependency(%q<erubi>.freeze, [">= 0"])
    s.add_development_dependency(%q<haml>.freeze, [">= 5"])
    s.add_development_dependency(%q<less>.freeze, [">= 0"])
    s.add_development_dependency(%q<minitest-reporters>.freeze, ["~> 1.1"])
    s.add_development_dependency(%q<rails>.freeze, [">= 4.0.0"])
    s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    s.add_development_dependency(%q<rake-compiler>.freeze, [">= 0"])
    s.add_development_dependency(%q<sass>.freeze, [">= 0"])
    s.add_development_dependency(%q<slim>.freeze, [">= 0"])
    s.add_development_dependency(%q<string_template>.freeze, [">= 0"])
    s.add_development_dependency(%q<unindent>.freeze, [">= 0"])
  else
    s.add_dependency(%q<temple>.freeze, [">= 0.8.2"])
    s.add_dependency(%q<thor>.freeze, [">= 0"])
    s.add_dependency(%q<tilt>.freeze, [">= 0"])
    s.add_dependency(%q<benchmark_driver>.freeze, [">= 0"])
    s.add_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_dependency(%q<coffee-script>.freeze, [">= 0"])
    s.add_dependency(%q<erubi>.freeze, [">= 0"])
    s.add_dependency(%q<haml>.freeze, [">= 5"])
    s.add_dependency(%q<less>.freeze, [">= 0"])
    s.add_dependency(%q<minitest-reporters>.freeze, ["~> 1.1"])
    s.add_dependency(%q<rails>.freeze, [">= 4.0.0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<rake-compiler>.freeze, [">= 0"])
    s.add_dependency(%q<sass>.freeze, [">= 0"])
    s.add_dependency(%q<slim>.freeze, [">= 0"])
    s.add_dependency(%q<string_template>.freeze, [">= 0"])
    s.add_dependency(%q<unindent>.freeze, [">= 0"])
  end
end
