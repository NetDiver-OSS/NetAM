# frozen_string_literal: true

require 'doorkeeper/grape/helpers'

module API
  module V1
    class Devices < Grape::API
      include API::V1::Defaults
      helpers Doorkeeper::Grape::Helpers

      before do
        doorkeeper_authorize!
        authorize_route!
      end

      resource :devices do
        desc 'Return all devices'
        get '', root: 'device' do
          Device.all.filter { |s| can?(:read, s) }
        end

        desc 'Create a device'
        params do
          requires :name, type: String
          requires :device_type_id, type: Integer
          optional :rack_height, type: Integer
          optional :depth_type, type: String
        end
        post '', root: 'device' do
          device = Device.create!(declared_params(include_missing: false))
          Permission.create!(
            {
              user_id: current_user.id,
              subject_class: 'Device',
              subject_id: device.id,
              action: 'manage'
            }
          )
          device
        end

        desc 'Return a device'
        params do
          requires :id, type: Integer, desc: 'ID of the device'
        end
        get ':id', root: 'device' do
          device = Device.where(id: permitted_params[:id]).first!
          authorize! :read, device
          device
        end
      end
    end
  end
end
