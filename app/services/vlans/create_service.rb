# frozen_string_literal: true

module Vlans
  class CreateService < BaseModelService
    def initialize(current_user = nil, params = nil)
      super
      @ts_collection_name = 'vlans'
      @ts_collection_fields = { name: 'string', description: 'string', vid: 'int32' }
    end

    def execute
      @vlan = Vlan.new(params)

      ensure_typesense_collections_exist

      if @vlan.save
        grant_permissions

        typesense_document_update_or_create(
          @vlan.id,
          {
            id: @vlan.id.to_s,
            name: @vlan.name,
            description: @vlan.description,
            vid: @vlan.vid,
            created_at: @vlan.created_at.to_i
          }
        )
      end

      @vlan
    end

    private

    def grant_permissions
      Permission.create!(
        {
          user_id: current_user.id,
          subject_class: 'Vlan',
          subject_id: @vlan.id,
          action: 'manage'
        }
      )
    end
  end
end
