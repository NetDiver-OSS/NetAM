class Section < ApplicationRecord
  has_many :usages, dependent: :destroy

  validates :name, :network, :schedule, presence: true
  validate :network_must_be_valid, :schedule_must_be_cron

  private

  def schedule_must_be_cron
    errors.add(:schedule, 'is not cron like') unless Fugit.parse(schedule).class == ::Fugit::Cron
  end

  def network_must_be_valid
    IPAddr.new network
  rescue IPAddr::Error
    errors.add(:network, 'is not valid')
  end
end
