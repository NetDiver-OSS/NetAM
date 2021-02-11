# frozen_string_literal: true

module Devices
  class DestroyService < BaseModelService
    attr_reader :device

    def initialize(current_user = nil, params = nil)
      @device = params.delete(:device)
      super
      @ts_collection_name = 'devices'
      @ts_collection_fields = { name: 'string' }
    end

    def execute
      ensure_typesense_collections_exist

      return unless @device.destroy

      drop_permissions
      typesense_document_delete(@device.id)
    end

    private

    def drop_permissions
      Permission.delete_by(subject_class: 'Device', subject_id: @device.id)
    end
  end
end
