# -*- encoding: utf-8 -*-
# stub: gettext_i18n_rails_js 1.3.0 ruby lib

Gem::Specification.new do |s|
  s.name = "gettext_i18n_rails_js".freeze
  s.version = "1.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Thomas Boerger".freeze, "Nubis".freeze]
  s.date = "2017-03-16"
  s.description = "    It will find translations inside your .js and .coffee files, then it will\n    create JSON versions of your .PO files and will let you serve them with the\n    rest of your assets, thus letting you access all your translations offline\n    from client side javascript.\n".freeze
  s.email = ["thomas@webhippie.de".freeze, "nubis@woobiz.com.ar".freeze]
  s.homepage = "https://github.com/webhippie/gettext_i18n_rails_js".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.3".freeze)
  s.rubygems_version = "3.1.4".freeze
  s.summary = "Extends gettext_i18n_rails making your .po files available to client side javascript as JSON".freeze

  s.installed_by_version = "3.1.4" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    s.add_development_dependency(%q<yard>.freeze, [">= 0"])
    s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_runtime_dependency(%q<rails>.freeze, [">= 3.2.0"])
    s.add_runtime_dependency(%q<gettext>.freeze, [">= 3.0.2"])
    s.add_runtime_dependency(%q<gettext_i18n_rails>.freeze, [">= 0.7.1"])
    s.add_runtime_dependency(%q<po_to_json>.freeze, [">= 1.0.0"])
  else
    s.add_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<yard>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_dependency(%q<rails>.freeze, [">= 3.2.0"])
    s.add_dependency(%q<gettext>.freeze, [">= 3.0.2"])
    s.add_dependency(%q<gettext_i18n_rails>.freeze, [">= 0.7.1"])
    s.add_dependency(%q<po_to_json>.freeze, [">= 1.0.0"])
  end
end
