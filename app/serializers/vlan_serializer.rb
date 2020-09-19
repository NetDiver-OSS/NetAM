# frozen_string_literal: true

class VlanSerializer < ActiveModel::Serializer
  attributes :id, :vid, :name, :description
end
