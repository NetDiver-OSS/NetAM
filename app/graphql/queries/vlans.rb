module Queries
  class Vlans < Queries::BaseQuery

    type [Types::VlanType], null: false

    def resolve
      ::Vlan.all.order(created_at: :desc)
    end
  end
end
