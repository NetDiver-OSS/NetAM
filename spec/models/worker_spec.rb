# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Worker, type: :model do
  subject(:worker) { described_class.new(name: 'TU title') }

  it 'should be valid' do
    expect(worker).to be_valid
  end

  it 'name should be present' do
    worker.name = nil
    expect(worker).not_to be_valid
  end

  context 'with creation' do
    let(:section1) { create :section }
    let(:section2) { create :section }

    it 'uuid should be present' do
      worker.save
      expect(described_class.last.uuid).not_to be_nil
    end

    it 'should create Cron on Sidekiq' do
      worker.sections << section1
      worker.save

      expect(Sidekiq::Cron::Job.find("section:#{section1.id}")).not_to be_nil
    end

    context 'with queue name setup' do
      it 'should use worker node queue' do
        worker_section1 = described_class.create!(name: 'TU', sections: [section1])
        job = Sidekiq::Cron::Job.find("section:#{section1.id}")

        expect(JSON.parse(job.message)['queue']).to eq("node:#{worker_section1.uuid}")
      end

      it 'should use default queue' do
        described_class.create!(name: 'TU', sections: [section1])
        job = Sidekiq::Cron::Job.find("section:#{section2.id}")

        expect(JSON.parse(job.message)['queue']).to eq('default')
      end
    end
  end
end
