# frozen_string_literal: true

module Admin
  class JobsController < ApplicationController
    # GET /admin/jobs
    def index
      @admin_jobs = Sidekiq::Cron::Job.all
    end

    # POST /admin/jobs/1/toggle
    def toggle
      job = Sidekiq::Cron::Job.find(params[:id])

      if job.status == 'enabled'
        job.disable!
      else
        job.enable!
      end

      redirect_to admin_jobs_url
    end
  end
end
