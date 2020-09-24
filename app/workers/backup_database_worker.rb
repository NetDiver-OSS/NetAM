class BackupDatabaseWorker
  include Sidekiq::Worker

  def perform(*args)
    backup = Backup::Database.new
    backup.dump
  end
end

