module Types
  class VlanType < Types::BaseObject
    field :id, ID, null: false
    field :vid, Integer, null: true
    field :name, String, null: true
    field :description, String, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
