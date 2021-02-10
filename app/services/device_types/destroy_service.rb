# frozen_string_literal: true

module DeviceTypes
  class DestroyService < BaseModelService
    attr_reader :device_type

    def initialize(current_user = nil, params = nil)
      @device_type = params.delete(:device_type)
      super
      @ts_collection_name = 'device_types'
      @ts_collection_fields = { name: 'string' }
    end

    def execute
      ensure_typesense_collections_exist

      return unless @device_type.destroy

      drop_permissions
      typesense_document_delete(@device_type.id)
    end

    private

    def drop_permissions
      Permission.delete_by(subject_class: 'DeviceType', subject_id: @device_type.id)
    end
  end
end
