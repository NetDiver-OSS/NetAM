# frozen_string_literal: true

class ApplicationJob < ActiveJob::Base
  include Sidekiq::Status::Worker

  def expiration
    @expiration ||= 60 * 60 * 24 * 30
  end

  # Automatically retry jobs that encountered a deadlock
  # retry_on ActiveRecord::Deadlocked

  # Most jobs are safe to ignore if the underlying records are no longer available
  # discard_on ActiveJob::DeserializationError
end
