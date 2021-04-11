# frozen_string_literal: true

module Usages
  class UpdateService < BaseModelService
    attr_reader :usage

    def initialize(current_user = nil, params = nil)
      @usage = params.delete(:usage)
      super
      @ts_collection_name = 'usages'
      @ts_collection_fields = { description: 'string', fqdn: 'string', ip_used: 'string', state: 'string', section_id: 'int64' }
    end

    def execute
      ensure_typesense_collections_exist

      if @usage.update(params)
        typesense_document_update_or_create(
          @usage.id,
          {
            id: @usage.id.to_s,
            ip_used: @usage.ip_used.to_s,
            fqdn: @usage.fqdn.to_s,
            description: @usage.description.to_s,
            state: @usage.state.to_s,
            section_id: @usage.section_id,
            created_at: Time.zone.now.to_i
          }
        )
      end

      @usage
    end
  end
end
