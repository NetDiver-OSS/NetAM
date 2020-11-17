# frozen_string_literal: true

module Backup
  module Helper
    def backup_path
      @backup_path ||= ENV['BACKUP_PATH'].presence || '/backups'
    end
  end
end
