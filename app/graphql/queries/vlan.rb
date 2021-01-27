module Queries
  class Vlan < Queries::BaseQuery

    type Types::VlanType, null: false
    argument :id, ID, required: true

    def resolve(id:)
      ::Vlan.find(id)
    rescue ActiveRecord::RecordNotFound => _e
      GraphQL::ExecutionError.new('Vlan does not exist.')
    rescue ActiveRecord::RecordInvalid => e
      GraphQL::ExecutionError.new("Invalid attributes for #{e.record.class}:"\
        " #{e.record.errors.full_messages.join(', ')}")
    end
  end
end
