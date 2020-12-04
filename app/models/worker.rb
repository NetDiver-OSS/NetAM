# frozen_string_literal: true

class Worker < ApplicationRecord
  has_many :sections, dependent: :nullify

  validates_associated :sections
  validates :name, presence: true

  before_commit do |worker|
    worker.uuid = SecureRandom.uuid if worker.uuid.nil?
  end

  after_save do
    Section.all.find_each(&:touch)
  end
end
