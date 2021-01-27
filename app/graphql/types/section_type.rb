module Types
  class SectionType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: true
    field :description, String, null: true
    field :network, String, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :schedule, String, null: true
    field :vlan, VlanType, null: true
    field :worker_id, Integer, null: true
    field :scan_type, String, null: true
  end
end
