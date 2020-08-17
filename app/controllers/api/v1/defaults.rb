module API
  module V1
    module Defaults
      extend ActiveSupport::Concern

      included do
        prefix 'api'
        version 'v1', using: :path
        default_format :json
        format :json
        formatter :json, Grape::Formatter::ActiveModelSerializers

        helpers do
          def declared_params(options = {})
            options = { include_parent_namespaces: false }.merge(options)
            declared(params, options).to_h.symbolize_keys
          end

          def permitted_params
            @permitted_params ||= declared(params, include_missing: false)
          end

          def current_user
            User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
          end

          def logger
            Rails.logger
          end
        end

        rescue_from ActiveRecord::RecordNotFound do |e|
          error_response(message: e.message, status: 404)
        end

        rescue_from ActiveRecord::RecordInvalid do |e|
          error_response(message: e.message, status: 422)
        end

        rescue_from ::CanCan::AccessDenied do
          error!('403 Forbidden', 403)
        end
      end
    end
  end
end
