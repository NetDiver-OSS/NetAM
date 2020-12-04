# -*- encoding: utf-8 -*-
# stub: grape-active_model_serializers 1.5.2 ruby lib

Gem::Specification.new do |s|
  s.name = "grape-active_model_serializers".freeze
  s.version = "1.5.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Jonathan Richard Henry Evans".freeze]
  s.date = "2018-03-14"
  s.description = "Provides a Formatter for the Grape API DSL to emit objects serialized with active_model_serializers.".freeze
  s.email = ["contact@jrhe.co.uk".freeze]
  s.homepage = "https://github.com/ruby-grape/grape-active_model_serializers".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.1.4".freeze
  s.summary = "Use active_model_serializer in grape".freeze

  s.installed_by_version = "3.1.4" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<grape>.freeze, [">= 0.8.0"])
    s.add_runtime_dependency(%q<active_model_serializers>.freeze, [">= 0.10.0"])
    s.add_development_dependency(%q<listen>.freeze, ["~> 3.0.7"])
    s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_development_dependency(%q<rack-test>.freeze, [">= 0"])
    s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    s.add_development_dependency(%q<guard-rspec>.freeze, [">= 0"])
    s.add_development_dependency(%q<rubocop>.freeze, ["= 0.41.2"])
  else
    s.add_dependency(%q<grape>.freeze, [">= 0.8.0"])
    s.add_dependency(%q<active_model_serializers>.freeze, [">= 0.10.0"])
    s.add_dependency(%q<listen>.freeze, ["~> 3.0.7"])
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_dependency(%q<rack-test>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<guard-rspec>.freeze, [">= 0"])
    s.add_dependency(%q<rubocop>.freeze, ["= 0.41.2"])
  end
end
