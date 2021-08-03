# frozen_string_literal: true

module NetDiver
  class ModuleLoader
    class << self
      def load_sidebar
        modules.map do |kclass|
          m = kclass.new
          {
            name: m.module_name,
            icon: m.module_icon,
            controllers: m.controller_list,
            links: m.module_links
          }
        end
      end

      private

      def modules
        ModuleRegister.subclasses.reverse
      end
    end
  end
end
