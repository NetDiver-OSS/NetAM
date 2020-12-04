# -*- encoding: utf-8 -*-
# stub: logstash-logger 0.26.1 ruby lib

Gem::Specification.new do |s|
  s.name = "logstash-logger".freeze
  s.version = "0.26.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["David Butler".freeze]
  s.date = "2018-02-14"
  s.description = "Ruby logger that writes directly to LogStash".freeze
  s.email = ["dwbutler@ucla.edu".freeze]
  s.homepage = "http://github.com/dwbutler/logstash-logger".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.1.4".freeze
  s.summary = "LogStash Logger for ruby".freeze

  s.installed_by_version = "3.1.4" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<logstash-event>.freeze, ["~> 1.2"])
    s.add_development_dependency(%q<rails>.freeze, [">= 0"])
    s.add_development_dependency(%q<redis>.freeze, [">= 0"])
    s.add_development_dependency(%q<poseidon>.freeze, [">= 0"])
    s.add_development_dependency(%q<aws-sdk-kinesis>.freeze, [">= 0"])
    s.add_development_dependency(%q<aws-sdk-firehose>.freeze, [">= 0"])
    s.add_development_dependency(%q<rspec>.freeze, [">= 3"])
    s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    s.add_development_dependency(%q<pry>.freeze, [">= 0"])
    s.add_development_dependency(%q<wwtd>.freeze, [">= 0"])
    s.add_development_dependency(%q<appraisal>.freeze, [">= 0"])
    s.add_development_dependency(%q<rubocop>.freeze, [">= 0"])
  else
    s.add_dependency(%q<logstash-event>.freeze, ["~> 1.2"])
    s.add_dependency(%q<rails>.freeze, [">= 0"])
    s.add_dependency(%q<redis>.freeze, [">= 0"])
    s.add_dependency(%q<poseidon>.freeze, [">= 0"])
    s.add_dependency(%q<aws-sdk-kinesis>.freeze, [">= 0"])
    s.add_dependency(%q<aws-sdk-firehose>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, [">= 3"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<pry>.freeze, [">= 0"])
    s.add_dependency(%q<wwtd>.freeze, [">= 0"])
    s.add_dependency(%q<appraisal>.freeze, [">= 0"])
    s.add_dependency(%q<rubocop>.freeze, [">= 0"])
  end
end
