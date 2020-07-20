module API
  module V1
    module Defaults
      extend ActiveSupport::Concern

      included do
        prefix 'requests.api'
        version 'requests.api.v1', using: :path
        default_format :json
        format :json
        formatter :json, Grape::Formatter::ActiveModelSerializers

        params do
          requires :token, type: String, desc: "Access token."
        end

        helpers do
          def declared_params(options = {})
            options = { include_parent_namespaces: false }.merge(options)
            declared(params, options).to_h.symbolize_keys
          end

          def authenticate!
            error!('Unauthorized. Invalid or expired token.', 401) unless current_user
          end

          def current_user
            token = ::APIKeys.where(access_token: params[:token]).first
            if token && !token.expired?
              @current_user = User.find(token.user_id)
            else
              false
            end
          end

          def permitted_params
            @permitted_params ||= declared(params, include_missing: false)
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
      end
    end
  end
end
