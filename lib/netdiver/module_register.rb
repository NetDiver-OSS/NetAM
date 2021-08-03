# frozen_string_literal: true

module NetDiver
  class ModuleRegister
    attr_accessor :module_name, :module_icon
    attr_reader :module_links, :controller_list

    def initialize
      @module_links = []
      @controller_list = []
    end

    def register_link(name, url)
      @module_links << {
        name: name,
        url: url
      }
    end

    def register_controller(name)
      @controller_list << name
    end
  end
end
