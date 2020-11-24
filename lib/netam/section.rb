# frozen_string_literal: true

module NetAM
  class Section
    def self.get_last_scan(section_id)
      Sidekiq.redis do |conn|
        conn.scan_each(match: 'sidekiq:status:*', count: 100).map do |key|
          status = Sidekiq::Status.get_all(key.split(':').last)
          return status['update_time'] if JSON.parse(status['args']).first['id'] == section_id
        end
      end

      0
    rescue StandardError
      0
    end
  end
end
