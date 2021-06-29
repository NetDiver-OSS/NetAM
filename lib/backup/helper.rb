# frozen_string_literal: true

module Backup
  module Helper
    def backup_path
      @backup_path ||= ENV.fetch('BACKUP_PATH', '/backups')
    end
  end
end
