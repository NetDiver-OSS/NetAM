module Netam
  class Scanner
    # @param [string] job
    def initialize(job)
      @job = job.constantize
    end

    # @param [int] id
    # @param [string] network
    def run(id, network)
      job_id = @job.perform_later({ id: id, network: network })

      job_id.provider_job_id
    end

    # @param [string] id
    def self.status(id)
      Sidekiq::Status.status(id)
    end
  end
end
