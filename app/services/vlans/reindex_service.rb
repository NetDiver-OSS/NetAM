# frozen_string_literal: true

module Vlans
  class ReindexService < BaseModelService
    attr_reader :vlan

    def initialize(current_user = nil, params = nil)
      @vlan = params
      super
      @ts_collection_name = 'vlans'
      @ts_collection_fields = { name: 'string', description: 'string', vid: 'int32' }
    end

    def execute
      ensure_typesense_collections_exist
      typesense_document_update_or_create(
        @vlan.id,
        {
          id: @vlan.id.to_s,
          name: @vlan.name,
          description: @vlan.description.to_s,
          vid: @vlan.vid,
          created_at: @vlan.created_at.to_i
        }
      )
    end
  end
end
