# frozen_string_literal: true

module Backup
  module Helper
    def backup_path
      @backup_path ||= if ENV['BACKUP_PATH'].present?
                         ENV['BACKUP_PATH']
                       else
                         '/backups'
                       end
    end
  end
end
