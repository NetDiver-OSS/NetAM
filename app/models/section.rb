class Section < ApplicationRecord
  has_many :usages, dependent: :destroy
  belongs_to :vlan

  validates :name, :network, presence: true
  validate :network_must_be_valid, :schedule_must_be_cron

  delegate :vid, :name, to: :vlan, prefix: true

  attr_accessor :run_scan, :notification_run_scan

  has_settings do |s|
    s.key :notification, defaults: { on_run: false }
  end

  after_save do |section|
    schedule_name = "section:#{section.id}"
    Sidekiq::Cron::Job.destroy(schedule_name)

    unless section.schedule.nil? || section.schedule.empty?
      Sidekiq::Cron::Job.new(
        name: schedule_name,
        class: 'ScanNetworkWithPingJob',
        cron: Fugit.parse(section.schedule).to_cron_s,
        args: [{ id: section.id, network: section.network }]
      ).save
    end
  end

  after_destroy do |section|
    Sidekiq::Cron::Job.destroy("section:#{section.id}")
    Permission.where(subject_class: 'Section', subject_id: section.id).delete_all
  end

  def request_unused_ip
    IPAddress(network).hosts.each do |ip|
      return ip.to_s if usages.where(ip_used: ip.to_s).empty?
    end
  end

  private

  def schedule_must_be_cron
    errors.add(:schedule, 'is not cron like') unless Fugit.parse(schedule).class == ::Fugit::Cron
  rescue StandardError
    false
  end

  def network_must_be_valid
    IPAddr.new network
  rescue IPAddr::Error
    errors.add(:network, 'is not valid')
  end
end
