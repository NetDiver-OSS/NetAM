# frozen_string_literal: true

class DeviceTypeSerializer < ActiveModel::Serializer
  attributes :id, :name, :color
end
