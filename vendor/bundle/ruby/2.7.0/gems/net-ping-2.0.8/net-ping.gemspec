require 'rubygems'
require 'rbconfig'

Gem::Specification.new do |spec|
  spec.name      = 'net-ping'
  spec.version   = '2.0.8'
  spec.license   = 'Artistic 2.0'
  spec.author    = 'Chris Chernesky'
  spec.email     = 'chris.netping@tinderglow.com'
  spec.homepage  = 'https://github.com/chernesk/net-ping'
  spec.summary   = 'A ping interface for Ruby.'
  spec.test_file = 'test/test_net_ping.rb'
  spec.files     = Dir['**/*'].reject{ |f| f.include?('git') }
  spec.metadata = {
    'bug_tracker_uri' => "#{spec.homepage}/issues",
    'changelog_uri' => "#{spec.homepage}/blob/master/CHANGES",
    'documentation_uri' => "https://www.rubydoc.info/gems/#{spec.name}",
    'homepage_uri' => spec.homepage,
    'source_code_uri' => spec.homepage
  }

  spec.extra_rdoc_files  = ['README.md', 'CHANGES', 'doc/ping.txt']

  # The TCP Ping class requires this for non-blocking sockets.
  spec.required_ruby_version = ">= 1.9.3"

  spec.add_development_dependency('test-unit', '>= 0')
  spec.add_development_dependency('fakeweb', '>= 0')
  spec.add_development_dependency('rake', '>= 0')
  spec.add_development_dependency('pry-byebug', '>= 0')

  if File::ALT_SEPARATOR
    require 'rbconfig'
    arch = RbConfig::CONFIG['build_os'] || 'mingw32' # JRuby
    spec.platform = Gem::Platform.new(['universal', arch])
    spec.platform.version = nil

    # Used for icmp pings.
    spec.add_dependency('win32-security', '>= 0.2.0')
    spec.add_dependency('cap2', '>= 0.2.2')
  end

  spec.description = <<-EOF
    The net-ping library provides a ping interface for Ruby. It includes
    separate TCP, HTTP, LDAP, ICMP, UDP, WMI (for Windows) and external ping
    classes.
  EOF
end
