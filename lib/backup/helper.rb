# frozen_string_literal: true

module Backup
  module Helper
    def backup_path
      @backup_path ||= ENV.fetch('BACKUP_PATH', '/backups') # rubocop:disable Rails/EnvironmentVariableAccess
    end
  end
end
