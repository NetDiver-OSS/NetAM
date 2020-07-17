# frozen_string_literal: true

class SectionSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :network, :schedule
end
