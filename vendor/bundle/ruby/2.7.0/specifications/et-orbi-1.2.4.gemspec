# -*- encoding: utf-8 -*-
# stub: et-orbi 1.2.4 ruby lib

Gem::Specification.new do |s|
  s.name = "et-orbi".freeze
  s.version = "1.2.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "bug_tracker_uri" => "http://github.com/floraison/et-orbi/issues", "changelog_uri" => "http://github.com/floraison/et-orbi/blob/master/CHANGELOG.md", "documentation_uri" => "http://github.com/floraison/et-orbi", "homepage_uri" => "http://github.com/floraison/et-orbi", "source_code_uri" => "http://github.com/floraison/et-orbi" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["John Mettraux".freeze]
  s.date = "2020-03-17"
  s.description = "Time zones for fugit and rufus-scheduler. Urbi et Orbi.".freeze
  s.email = ["jmettraux+flor@gmail.com".freeze]
  s.homepage = "http://github.com/floraison/et-orbi".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.1.4".freeze
  s.summary = "time with zones".freeze

  s.installed_by_version = "3.1.4" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<tzinfo>.freeze, [">= 0"])
    s.add_development_dependency(%q<rspec>.freeze, ["~> 3.8"])
    s.add_development_dependency(%q<chronic>.freeze, ["~> 0.10"])
  else
    s.add_dependency(%q<tzinfo>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.8"])
    s.add_dependency(%q<chronic>.freeze, ["~> 0.10"])
  end
end
