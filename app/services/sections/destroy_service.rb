# frozen_string_literal: true

module Sections
  class DestroyService < BaseModelService
    attr_reader :section

    def initialize(current_user = nil, params = nil)
      @section = params.delete(:section)
      super
      @ts_collection_name = 'sections'
      @ts_collection_fields = { name: 'string', description: 'string', network: 'string' }
    end

    def execute
      ensure_typesense_collections_exist

      return unless @section.destroy

      drop_permissions
      typesense_document_delete(@section.id)
    end

    private

    def drop_permissions
      Permission.delete_by(subject_class: 'Section', subject_id: @section.id)
    end
  end
end
