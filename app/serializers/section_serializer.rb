class SectionSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :network, :schedule
end
