# frozen_string_literal: true

module Sections
  class CreateService < BaseModelService
    def initialize(current_user = nil, params = nil)
      super
      @ts_collection_name = 'sections'
      @ts_collection_fields = { name: 'string', description: 'string', network: 'string' }
    end

    def execute
      @section = Section.new(params)

      ensure_typesense_collections_exist

      if @section.save
        grant_permissions

        typesense_document_update_or_create(
          @section.id,
          {
            id: @section.id.to_s,
            name: @section.name,
            description: @section.description,
            network: @section.network,
            created_at: @section.created_at.to_i
          }
        )
      end

      @section
    end

    private

    def grant_permissions
      Permission.create!(
        {
          user_id: current_user.id,
          subject_class: 'Section',
          subject_id: @section.id,
          action: 'manage'
        }
      )
    end
  end
end
