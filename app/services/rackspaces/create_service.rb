# frozen_string_literal: true

module Rackspaces
  class CreateService < BaseModelService
    def initialize(current_user = nil, params = nil)
      super
      @ts_collection_name = 'rackspaces'
      @ts_collection_fields = { name: 'string', location: 'string' }
    end

    def execute
      @rackspace = Rackspace.new(params)

      ensure_typesense_collections_exist

      if @rackspace.save
        grant_permissions

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

    private

    def grant_permissions
      Permission.create!(
        {
          user_id: current_user.id,
          subject_class: 'Rackspace',
          subject_id: @rackspace.id,
          action: 'manage'
        }
      )
    end
  end
end
