# -*- encoding: utf-8 -*-
# stub: omniauth-ldap 2.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "omniauth-ldap".freeze
  s.version = "2.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Ping Yu".freeze, "Tom Milewski".freeze]
  s.date = "2018-01-09"
  s.description = "A LDAP strategy for OmniAuth.".freeze
  s.email = ["ping@intridea.com".freeze, "tmilewski@gmail.com".freeze]
  s.homepage = "https://github.com/intridea/omniauth-ldap".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.1.4".freeze
  s.summary = "A LDAP strategy for OmniAuth.".freeze

  s.installed_by_version = "3.1.4" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<omniauth>.freeze, ["~> 1.8.1"])
    s.add_runtime_dependency(%q<net-ldap>.freeze, ["~> 0.16"])
    s.add_runtime_dependency(%q<pyu-ruby-sasl>.freeze, ["~> 0.0.3.3"])
    s.add_runtime_dependency(%q<rubyntlm>.freeze, ["~> 0.6.2"])
    s.add_development_dependency(%q<rspec>.freeze, ["~> 3.0"])
    s.add_development_dependency(%q<simplecov>.freeze, [">= 0"])
    s.add_development_dependency(%q<rack-test>.freeze, [">= 0"])
  else
    s.add_dependency(%q<omniauth>.freeze, ["~> 1.8.1"])
    s.add_dependency(%q<net-ldap>.freeze, ["~> 0.16"])
    s.add_dependency(%q<pyu-ruby-sasl>.freeze, ["~> 0.0.3.3"])
    s.add_dependency(%q<rubyntlm>.freeze, ["~> 0.6.2"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.0"])
    s.add_dependency(%q<simplecov>.freeze, [">= 0"])
    s.add_dependency(%q<rack-test>.freeze, [">= 0"])
  end
end
