# frozen_string_literal: true

class BackupDatabaseWorker
  include Sidekiq::Worker
  sidekiq_options retry: 3

  def perform
    backup = Backup::Database.new
    backup.dump
  end
end
