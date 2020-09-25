module Admin
  class BackupsController < ApplicationController
    def index
      @backups = Backup::Manager.new.list_backups
    end

    # POST /admin/backups
    def create
      BackupDatabaseWorker.perform_async

      redirect_to admin_backups_path, notice: 'Backup job launched !'
    end
  end
end
