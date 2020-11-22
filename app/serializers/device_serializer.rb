# frozen_string_literal: true

class DeviceSerializer < ActiveModel::Serializer
  attributes :id, :nam, :h_size, :p_size
end
