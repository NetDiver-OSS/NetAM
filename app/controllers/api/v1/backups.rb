# frozen_string_literal: true

require 'doorkeeper/grape/helpers'

module API
  module V1
    class Backups < Grape::API
      include API::V1::Defaults
      helpers Doorkeeper::Grape::Helpers

      before do
        doorkeeper_authorize!
        authorize_route!
        admin?
      end

      resource :backups do
        desc 'Return all backups'
        get '', root: 'backup' do
          render backups: Backup::Manager.new.list_backups
        end

        desc 'Create a backup'
        post '', root: 'backup' do
          status 201
          BackupDatabaseWorker.perform_async
        end
      end
    end
  end
end
