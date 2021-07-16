# frozen_string_literal: true

module Netutils
  class Module < ::NetDiver::ModuleRegister
    def initialize
      super

      @module_name = 'NetUtils'
      @module_icon = %w[solid tools]

      register_link(_('IP Calculator'), '/utils/calculator')
      register_link(_('MAC Vendor'), '/utils/mac_vendor')
      register_link(_('Network Splitter'), '/utils/network_splitter')
      register_link(_('PTR Resolver'), '/utils/ptr_resolution')
      register_link(_('DNS Resolver'), '/utils/dns_resolver')
      register_link(_('Whois'), '/utils/whois')

      register_controller('utils')
    end
  end
end
