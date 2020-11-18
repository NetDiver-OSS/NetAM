# frozen_string_literal: true

class Worker < ApplicationRecord
  has_many :sections, dependent: :nullify

  validates_associated :sections
  validates :name, presence: true
end
