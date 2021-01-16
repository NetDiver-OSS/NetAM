# frozen_string_literal: true

class RackspaceSerializer < ActiveModel::Serializer
  attributes :id, :name, :unit_height, :location
end
