module NetAM
  class Scanner
    # @param [string] job
    def initialize(job)
      @job = job.constantize
    end

    # @param [int] id
    # @param [string] network
    def run(id, network)
      queue = ::Section.find(id).worker.nil? ? "default" : "node:#{::Section.find(id).worker.uuid}"
      job_id = @job.set(queue: queue).perform_async({ id: id, network: network })

      job_id
    end

    # @param [string] id
    def self.status(id)
      Sidekiq::Status.status(id)
    end
  end
end
