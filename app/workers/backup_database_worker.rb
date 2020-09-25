class BackupDatabaseWorker
  include Sidekiq::Worker

  def perform
    backup = Backup::Database.new
    backup.dump
  end
end
