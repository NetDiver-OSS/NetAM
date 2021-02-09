# frozen_string_literal: true

module Vlans
  class DestroyService < BaseModelService
    attr_reader :vlan

    def initialize(current_user = nil, params = nil)
      @vlan = params.delete(:vlan)
      super
      @ts_collection_name = 'vlans'
      @ts_collection_fields = { name: 'string', description: 'string', vid: 'int32' }
    end

    def execute
      ensure_typesense_collections_exist

      return unless @vlan.destroy

      drop_permissions
      typesense_document_delete(@vlan.id)
    end

    private

    def drop_permissions
      Permission.delete_by(subject_class: 'Vlan', subject_id: @vlan.id)
    end
  end
end
