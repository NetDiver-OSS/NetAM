# frozen_string_literal: true

module NetDiver
  class Section
    def self.get_last_jid(section_id)
      status = get_last_job(section_id)
      return status['jid'] unless status.nil?

      0
    end

    def self.get_last_scan(section_id)
      status = get_last_job(section_id)
      return status['update_time'] unless status.nil?

      0
    end

    def self.get_all_jobs(section_id)
      Sidekiq.redis do |conn|
        conn.scan_each(match: 'sidekiq:status:*').filter_map do |key|
          job = Sidekiq::Status.get_all(key.split(':').last)
          job if JSON.parse(job['args']).first['id'] == section_id
        end
      end
    end

    def self.get_last_job(section_id)
      Sidekiq.redis do |conn|
        conn.scan_each(match: 'sidekiq:status:*', count: 100).reverse_each do |key|
          status = Sidekiq::Status.get_all(key.split(':').last)
          return status if JSON.parse(status['args']).first['id'] == section_id
        end
      end

      nil
    end
  end
end
