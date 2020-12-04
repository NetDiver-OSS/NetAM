require 'grape'
require 'grape/cancan/version'
require 'active_support/inflector'
require 'active_support/core_ext/module/delegation'

module Grape
  module CanCan
    module API
      # Convienience method to authorize every route
      def authorize_routes!
        before { authorize_route! }
      end
    end

    module Endpoint
      # Returns an instance of the CanCan ability
      def current_ability
        @current_ability ||= ::Ability.new(current_user)
      end
      delegate :can?, :cannot?, :authorize!, to: :current_ability

      # Call authorize using the :authorize key on the route
      def authorize_route!
        opts = env['api.endpoint'].options[:route_options]
        authorize!(*opts[:authorize]) if opts.key?(:authorize)
      end
    end
  end
end

Grape::API::Instance.extend Grape::CanCan::API
Grape::Endpoint.send :include, Grape::CanCan::Endpoint
