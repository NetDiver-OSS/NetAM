# frozen_string_literal: true

module DeviceTypes
  class CreateService < BaseModelService
    def initialize(current_user = nil, params = nil)
      super
      @ts_collection_name = 'device_types'
      @ts_collection_fields = { name: 'string' }
    end

    def execute
      @device_type = DeviceType.new(params)

      ensure_typesense_collections_exist

      if @device_type.save
        grant_permissions

        typesense_document_update_or_create(
          @device_type.id,
          {
            id: @device_type.id.to_s,
            name: @device_type.name,
            created_at: @device_type.created_at.to_i
          }
        )
      end

      @device_type
    end

    private

    def grant_permissions
      Permission.create!(
        {
          user_id: current_user.id,
          subject_class: 'DeviceType',
          subject_id: @device_type.id,
          action: 'manage'
        }
      )
    end
  end
end
