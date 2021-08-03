# frozen_string_literal: true

class BaseModelService
  attr_reader :current_user, :params

  def initialize(current_user = nil, params = {})
    @current_user = current_user
    @params = params.dup
  end

  private

  def ensure_typesense_collections_exist
    return unless Rails.configuration.netdiver.dig(:typesense, :enabled)

    TYPESENSE.collections[@ts_collection_name].retrieve
  rescue Typesense::Error::ObjectNotFound
    TYPESENSE.collections.create(typesense_collections)
  end

  def typesense_collections
    {
      name: @ts_collection_name,
      fields: @ts_collection_fields.map do |n, t|
        { name: n, type: t, optional: n != 'name' }
      end.push(
        {
          name: 'created_at',
          type: 'int64'
        }
      ),
      default_sorting_field: 'created_at'
    }
  end

  def typesense_document_update_or_create(id, document)
    return unless Rails.configuration.netdiver.dig(:typesense, :enabled)

    TYPESENSE.collections[@ts_collection_name].documents[id.to_s].update(document)
  rescue Typesense::Error::ObjectNotFound
    TYPESENSE.collections[@ts_collection_name].documents.create(document)
  end

  def typesense_document_delete(id)
    return unless Rails.configuration.netdiver.dig(:typesense, :enabled)

    TYPESENSE.collections[@ts_collection_name].documents[id.to_s].delete
  rescue Typesense::Error::ObjectNotFound
    nil
  end
end
