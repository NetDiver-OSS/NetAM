# frozen_string_literal: true

module NetDiver
  class Module < ::NetDiver::ModuleRegister
    def initialize
      super

      @module_name = 'NetDiver'
      @module_icon = %w[solid server]

      register_link(_('Sections'), '/sections')
      register_link(_('Vlans'), '/vlans')
      register_link(_('Devices'), '/devices')
      register_link(_('Devices Type'), '/device_types')
      register_link(_('Rackspaces'), '/rackspaces')

      register_controller('sections')
      register_controller('vlans')
      register_controller('devices')
      register_controller('device_types')
      register_controller('rackspaces')
    end
  end
end
