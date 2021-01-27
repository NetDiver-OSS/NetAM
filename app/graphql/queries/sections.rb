module Queries
  class Sections < Queries::BaseQuery

    type [Types::SectionType], null: false

    def resolve
      ::Section.all.order(created_at: :desc)
    end
  end
end
