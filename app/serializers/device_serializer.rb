# frozen_string_literal: true

class DeviceSerializer < ActiveModel::Serializer
  attributes :id, :name, :rack_height, :depth_type, :device_type_id
end
