# frozen_string_literal: true

module Sections
  class ReindexService < BaseModelService
    attr_reader :section

    def initialize(current_user = nil, params = nil)
      @section = params
      super
      @ts_collection_name = 'sections'
      @ts_collection_fields = { name: 'string', description: 'string', network: 'string' }
    end

    def execute
      ensure_typesense_collections_exist
      typesense_document_update_or_create(
        @section.id,
        {
          id: @section.id.to_s,
          name: @section.name,
          description: @section.description.to_s,
          network: @section.network,
          created_at: @section.created_at.to_i
        }
      )
    end
  end
end
