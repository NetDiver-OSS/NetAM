# frozen_string_literal: true

module Backup
  class Manager
    include Backup::Helper

    def list_backups
      Dir.glob("#{backup_path}/*").map { |backup| backup.gsub("#{backup_path}/", "") }
    end
  end
end
