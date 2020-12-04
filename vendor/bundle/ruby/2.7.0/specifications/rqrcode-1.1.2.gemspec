# -*- encoding: utf-8 -*-
# stub: rqrcode 1.1.2 ruby lib

Gem::Specification.new do |s|
  s.name = "rqrcode".freeze
  s.version = "1.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Duncan Robertson".freeze]
  s.bindir = "exe".freeze
  s.date = "2019-11-07"
  s.description = "rqrcode is a library for encoding QR Codes. The simple\ninterface allows you to create QR Code data structures\nand then render them in the way you choose.\n".freeze
  s.email = ["duncan@whomwah.com".freeze]
  s.homepage = "https://github.com/whomwah/rqrcode".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new("~> 2.3".freeze)
  s.rubygems_version = "3.1.4".freeze
  s.summary = "A library to encode QR Codes".freeze

  s.installed_by_version = "3.1.4" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<rqrcode_core>.freeze, ["~> 0.1"])
    s.add_runtime_dependency(%q<chunky_png>.freeze, ["~> 1.0"])
    s.add_development_dependency(%q<bundler>.freeze, ["~> 2.0"])
    s.add_development_dependency(%q<rake>.freeze, ["~> 12.0"])
    s.add_development_dependency(%q<rspec>.freeze, ["~> 3.5"])
  else
    s.add_dependency(%q<rqrcode_core>.freeze, ["~> 0.1"])
    s.add_dependency(%q<chunky_png>.freeze, ["~> 1.0"])
    s.add_dependency(%q<bundler>.freeze, ["~> 2.0"])
    s.add_dependency(%q<rake>.freeze, ["~> 12.0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.5"])
  end
end
