# frozen_string_literal: true

module Usages
  class CreateService < BaseModelService
    def initialize(current_user = nil, params = nil)
      super
      @ts_collection_name = 'usages'
      @ts_collection_fields = {
        description: 'string',
        fqdn: 'string',
        ip_used: 'string',
        state: 'string',
        section_id: 'int64',
        section_name: 'string'
      }    end

    def execute
      @usage = Usage.new(params)

      ensure_typesense_collections_exist

      if @usage.save
        typesense_document_update_or_create(
          @usage.id,
          {
            id: @usage.id.to_s,
            ip_used: @usage.ip_used.to_s,
            fqdn: @usage.fqdn.to_s,
            description: @usage.description.to_s,
            state: @usage.state.to_s,
            section_id: @usage.section_id,
            section_name: @usage.section.name.to_s,
            created_at: Time.zone.now.to_i
          }
        )
      end

      @usage
    end
  end
end
