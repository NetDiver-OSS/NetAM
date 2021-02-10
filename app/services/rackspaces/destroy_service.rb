# frozen_string_literal: true

module Rackspaces
  class DestroyService < BaseModelService
    attr_reader :rackspace

    def initialize(current_user = nil, params = nil)
      @rackspace = params.delete(:rackspace)
      super
      @ts_collection_name = 'rackspaces'
      @ts_collection_fields = { name: 'string', location: 'string' }
    end

    def execute
      ensure_typesense_collections_exist

      return unless @rackspace.destroy

      drop_permissions
      typesense_document_delete(@rackspace.id)
    end

    private

    def drop_permissions
      Permission.delete_by(subject_class: 'Rackspace', subject_id: @rackspace.id)
    end
  end
end
