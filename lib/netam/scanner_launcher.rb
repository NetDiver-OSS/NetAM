# frozen_string_literal: true

module NetAM
  class ScannerLauncher
    # @param [string] job
    def initialize(job)
      @job = job.constantize
    end

    # @param [int] id
    # @param [string] network
    def run(id, network)
      queue = ::Section.find(id).worker.nil? ? 'default' : "node:#{::Section.find(id).worker.uuid}"

      @job.set(queue: queue).perform_async({ id: id, network: network })
    end

    # @param [string] id
    def self.status(id)
      Sidekiq::Status.status(id)
    end
  end
end
