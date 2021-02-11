# frozen_string_literal: true

module Devices
  class UpdateService < BaseModelService
    attr_reader :device

    def initialize(current_user = nil, params = nil)
      @device = params.delete(:device)
      super
      @ts_collection_name = 'devices'
      @ts_collection_fields = { name: 'string' }
    end

    def execute
      ensure_typesense_collections_exist

      if @device.update(params)
        typesense_document_update_or_create(
          @device.id,
          {
            id: @device.id.to_s,
            name: @device.name,
            created_at: @device.created_at.to_i
          }
        )
      end

      @device
    end
  end
end
