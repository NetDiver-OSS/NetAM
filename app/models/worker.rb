# frozen_string_literal: true

class Worker < ApplicationRecord
  has_many :sections, dependent: :nullify

  validates_associated :sections
  validates :id, :name, presence: true
  validates :id, numericality: true
  validates :vid, uniqueness: true
end
