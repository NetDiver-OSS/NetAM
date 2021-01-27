# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :sections, resolver: Queries::Sections
    field :section, resolver: Queries::Section
    field :vlans, resolver: Queries::Vlans
    field :vlan, resolver: Queries::Vlan
  end
end
