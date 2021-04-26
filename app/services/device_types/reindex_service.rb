# frozen_string_literal: true

module DeviceTypes
  class ReindexService < BaseModelService
    attr_reader :device_type

    def initialize(current_user = nil, params = nil)
      @device_type = params
      super
      @ts_collection_name = 'device_types'
      @ts_collection_fields = { name: 'string' }
    end

    def execute
      ensure_typesense_collections_exist

      typesense_document_update_or_create(
        @device_type.id,
        {
          id: @device_type.id.to_s,
          name: @device_type.name,
          created_at: @device_type.created_at.to_i
        }
      )
    end
  end
end
