module Queries
  class Section < Queries::BaseQuery

    type Types::SectionType, null: false
    argument :id, ID, required: true

    def resolve(id:)
      ::Section.find(id)
    rescue ActiveRecord::RecordNotFound => _e
      GraphQL::ExecutionError.new('Section does not exist.')
    rescue ActiveRecord::RecordInvalid => e
      GraphQL::ExecutionError.new("Invalid attributes for #{e.record.class}:"\
        " #{e.record.errors.full_messages.join(', ')}")
    end
  end
end
