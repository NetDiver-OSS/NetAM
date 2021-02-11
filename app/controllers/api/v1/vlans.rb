# frozen_string_literal: true

require 'doorkeeper/grape/helpers'

module API
  module V1
    class Vlans < Grape::API
      include API::V1::Defaults
      helpers Doorkeeper::Grape::Helpers

      before do
        doorkeeper_authorize!
        authorize_route!
      end

      resource :vlans do
        desc 'Return all vlans'
        get '', root: 'vlan' do
          Vlan.all.filter { |s| can?(:read, s) }
        end

        desc 'Create a vlan'
        params do
          requires :name, type: String
          requires :vid, type: Integer
          optional :description, type: String
        end
        post '', root: 'vlan' do
          ::Vlans::CreateService.new(current_user, declared_params(include_missing: false)).execute
        end

        desc 'Return a vlan'
        params do
          requires :id, type: String, desc: 'ID of the vlan'
        end
        get ':id', root: 'vlan' do
          vlan = Vlan.where(id: permitted_params[:id]).first!
          authorize! :read, vlan
          vlan
        end
      end
    end
  end
end
