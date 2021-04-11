# frozen_string_literal: true

require 'doorkeeper/grape/helpers'

module API
  module V1
    class Search < Grape::API
      include API::V1::Defaults
      helpers Doorkeeper::Grape::Helpers

      resource :search do
        desc 'Return search'
        params do
          requires :searches, type: Array
        end
        post '', root: 'search' do
          TYPESENSE.multi_search.perform(permitted_params)
        end
      end
    end
  end
end
