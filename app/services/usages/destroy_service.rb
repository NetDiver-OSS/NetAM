# frozen_string_literal: true

module Usages
  class DestroyService < BaseModelService
    attr_reader :usage

    def initialize(current_user = nil, params = nil)
      @usage = params.delete(:section)
      super
      @ts_collection_name = 'usage'
      @ts_collection_fields = { description: 'string', fqdn: 'string', ip_used: 'string', state: 'string' }
    end

    def execute
      ensure_typesense_collections_exist

      return unless @usage.destroy

      typesense_document_delete(@usage.id)
    end
  end
end
