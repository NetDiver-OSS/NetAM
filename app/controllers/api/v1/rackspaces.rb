# frozen_string_literal: true

require 'doorkeeper/grape/helpers'

module API
  module V1
    class Rackspaces < Grape::API
      include API::V1::Defaults
      helpers Doorkeeper::Grape::Helpers

      before do
        doorkeeper_authorize!
        authorize_route!
      end

      resource :rackspaces do
        desc 'Return all rackspaces'
        get '', root: 'rackspace' do
          Rackspace.all.filter { |s| can?(:read, s) }
        end

        desc 'Create a rackspace'
        params do
          requires :name, type: String
          requires :unit_height, type: Integer
          requires :location, type: String
        end
        post '', root: 'rackspace' do
          ::Rackspaces::CreateService.new(current_user, declared_params(include_missing: false)).execute
        end

        desc 'Return a rackspace'
        params do
          requires :id, type: Integer, desc: 'ID of the rackspace'
        end
        get ':id', root: 'rackspace' do
          rackspace = Rackspace.where(id: permitted_params[:id]).first!
          authorize! :read, rackspace
          rackspace
        end
      end
    end
  end
end
