# -*- encoding: utf-8 -*-
# stub: ledermann-rails-settings 2.5.0 ruby lib

Gem::Specification.new do |s|
  s.name = "ledermann-rails-settings".freeze
  s.version = "2.5.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Georg Ledermann".freeze]
  s.date = "2019-08-25"
  s.description = "Settings gem for Ruby on Rails".freeze
  s.email = ["mail@georg-ledermann.de".freeze]
  s.homepage = "https://github.com/ledermann/rails-settings".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.4".freeze)
  s.rubygems_version = "3.1.4".freeze
  s.summary = "Ruby gem to handle settings for ActiveRecord instances by storing them as serialized Hash in a separate database table. Namespaces and defaults included.".freeze

  s.installed_by_version = "3.1.4" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<activerecord>.freeze, [">= 4.2"])
    s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    s.add_development_dependency(%q<sqlite3>.freeze, [">= 0"])
    s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_development_dependency(%q<coveralls>.freeze, [">= 0"])
    s.add_development_dependency(%q<simplecov>.freeze, [">= 0.11.2"])
  else
    s.add_dependency(%q<activerecord>.freeze, [">= 4.2"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<sqlite3>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_dependency(%q<coveralls>.freeze, [">= 0"])
    s.add_dependency(%q<simplecov>.freeze, [">= 0.11.2"])
  end
end
