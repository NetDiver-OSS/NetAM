# -*- encoding: utf-8 -*-
# stub: po_to_json 1.0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "po_to_json".freeze
  s.version = "1.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Thomas Boerger".freeze, "Nubis".freeze]
  s.date = "2015-11-03"
  s.description = "    Convert gettext PO files to JSON objects so that you can use it in your\n    application.\n".freeze
  s.email = ["thomas@webhippie.de".freeze, "nubis@woobiz.com.ar".freeze]
  s.homepage = "https://github.com/webhippie/po_to_json".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.3".freeze)
  s.rubygems_version = "3.1.4".freeze
  s.summary = "Convert gettext PO files to JSON".freeze

  s.installed_by_version = "3.1.4" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    s.add_development_dependency(%q<yard>.freeze, [">= 0"])
    s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_runtime_dependency(%q<json>.freeze, [">= 1.6.0"])
  else
    s.add_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<yard>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_dependency(%q<json>.freeze, [">= 1.6.0"])
  end
end
