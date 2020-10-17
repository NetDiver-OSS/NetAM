require 'rails_helper'

describe "Job", type: :request do
  before(:each) do
    admin = User.create!(email: "admin@netam.local", password: "azertyuiop123", admin: true)

    sign_in admin
  end

  describe "GET /index" do
    it "renders a successful response" do
      get admin_jobs_url
      expect(response).to be_successful
    end
  end

  describe "POST /toggle" do
    before do
      Sidekiq::Cron::Job.new(
        name: "unit_test",
        class: 'ScanNetworkWithPingWorker',
        cron: Fugit.parse('every day').to_cron_s
      ).save
    end

    it "should disable job when is enabled" do
      Sidekiq::Cron::Job.find('unit_test').enable!

      post toggle_admin_job_url('unit_test')

      expect(Sidekiq::Cron::Job.find('unit_test').status).to eq('disabled')
      expect(response).to redirect_to(admin_jobs_url)
    end

    it "should enable job when is disabled" do
      Sidekiq::Cron::Job.find('unit_test').disable!

      post toggle_admin_job_url('unit_test')

      expect(Sidekiq::Cron::Job.find('unit_test').status).to eq('enabled')
      expect(response).to redirect_to(admin_jobs_url)
    end
  end
end
