class Section < ApplicationRecord
  has_many :usages, dependent: :destroy

  validates :name, :network, presence: true
  validate :network_must_be_valid, :schedule_must_be_cron

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
