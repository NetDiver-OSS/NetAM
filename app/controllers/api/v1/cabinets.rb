# frozen_string_literal: true

require 'doorkeeper/grape/helpers'

module API
  module V1
    class Cabinets < Grape::API
      include API::V1::Defaults
      helpers Doorkeeper::Grape::Helpers

      before do
        doorkeeper_authorize!
        authorize_route!
      end

      resource :cabinets do
        desc 'Return all cabinets'
        get '', root: 'cabinet' do
          Cabinet.all.filter { |s| can?(:read, s) }
        end

        desc 'Create a cabinet'
        params do
          requires :name, type: String
          requires :unit_height, type: Integer
          requires :location, type: String
        end
        post '', root: 'cabinet' do
          cabinet = Cabinet.create!(declared_params(include_missing: false))
          Permission.create!(
            {
              user_id: current_user.id,
              subject_class: 'Cabinet',
              subject_id: cabinet.id,
              action: 'manage'
            }
          )
          cabinet
        end

        desc 'Return a cabinet'
        params do
          requires :id, type: Integer, desc: 'ID of the cabinet'
        end
        get ':id', root: 'cabinet' do
          cabinet = Cabinet.where(id: permitted_params[:id]).first!
          authorize! :read, cabinet
          cabinet
        end
      end
    end
  end
end
