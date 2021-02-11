# frozen_string_literal: true

module Devices
  class CreateService < BaseModelService
    def initialize(current_user = nil, params = nil)
      super
      @ts_collection_name = 'devices'
      @ts_collection_fields = { name: 'string' }
    end

    def execute
      @device = Device.new(params)

      ensure_typesense_collections_exist

      if @device.save
        grant_permissions

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

    private

    def grant_permissions
      Permission.create!(
        {
          user_id: current_user.id,
          subject_class: 'Device',
          subject_id: @device.id,
          action: 'manage'
        }
      )
    end
  end
end
