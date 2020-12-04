# -*- encoding: utf-8 -*-
# stub: net-ping 2.0.8 ruby lib

Gem::Specification.new do |s|
  s.name = "net-ping".freeze
  s.version = "2.0.8"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "bug_tracker_uri" => "https://github.com/chernesk/net-ping/issues", "changelog_uri" => "https://github.com/chernesk/net-ping/blob/master/CHANGES", "documentation_uri" => "https://www.rubydoc.info/gems/net-ping", "homepage_uri" => "https://github.com/chernesk/net-ping", "source_code_uri" => "https://github.com/chernesk/net-ping" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Chris Chernesky".freeze]
  s.date = "2020-06-17"
  s.description = "    The net-ping library provides a ping interface for Ruby. It includes\n    separate TCP, HTTP, LDAP, ICMP, UDP, WMI (for Windows) and external ping\n    classes.\n".freeze
  s.email = "chris.netping@tinderglow.com".freeze
  s.extra_rdoc_files = ["README.md".freeze, "CHANGES".freeze, "doc/ping.txt".freeze]
  s.files = ["CHANGES".freeze, "README.md".freeze, "doc/ping.txt".freeze]
  s.homepage = "https://github.com/chernesk/net-ping".freeze
  s.licenses = ["Artistic 2.0".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.3".freeze)
  s.rubygems_version = "3.1.4".freeze
  s.summary = "A ping interface for Ruby.".freeze

  s.installed_by_version = "3.1.4" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<test-unit>.freeze, [">= 0"])
    s.add_development_dependency(%q<fakeweb>.freeze, [">= 0"])
    s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    s.add_development_dependency(%q<pry-byebug>.freeze, [">= 0"])
  else
    s.add_dependency(%q<test-unit>.freeze, [">= 0"])
    s.add_dependency(%q<fakeweb>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<pry-byebug>.freeze, [">= 0"])
  end
end
