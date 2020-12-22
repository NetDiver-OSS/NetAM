# frozen_string_literal: true

class CabinetSerializer < ActiveModel::Serializer
  attributes :id, :name, :unit_height, :location
end
