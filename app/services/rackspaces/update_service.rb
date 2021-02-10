# frozen_string_literal: true

module Rackspaces
  class UpdateService < BaseModelService
    attr_reader :rackspace

    def initialize(current_user = nil, params = nil)
      @rackspace = params.delete(:rackspace)
      super
      @ts_collection_name = 'rackspaces'
      @ts_collection_fields = { name: 'string', location: 'string' }
    end

    def execute
      ensure_typesense_collections_exist

      if @rackspace.update(params)
        typesense_document_update_or_create(
          @rackspace.id,
          {
            id: @rackspace.id.to_s,
            name: @rackspace.name,
            location: @rackspace.location,
            created_at: @rackspace.created_at.to_i
          }
        )
      end

      @rackspace
    end
  end
end
