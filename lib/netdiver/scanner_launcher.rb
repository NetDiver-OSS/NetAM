# frozen_string_literal: true

module NetDiver
  class ScannerLauncher
    # @param [string] job
    def initialize(job)
      @job = job.constantize
    end

    # @param [int] id
    # @param [string] network
    def run(id, network)
      queue = ::Section.find(id).worker.nil? ? 'default' : "node:#{::Section.find(id).worker.uuid}"

      @job.set(queue: queue).perform_async({ id: id, network: network, scan_type: ::Section.find(id).scan_type })
    end

    # @param [string] id
    def self.status(id)
      Sidekiq::Status.status(id)
    end
  end
end
