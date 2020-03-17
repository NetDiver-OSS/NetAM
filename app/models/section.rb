class Section < ApplicationRecord
  has_many :usages, dependent: :destroy

  validates :name, :network, presence: true
  validate :network_must_be_valid

  private

  def network_must_be_valid
    begin
      IPAddr.new network
    rescue IPAddr::Error
      errors.add(:network, "is not valid")
    end
  end
end
