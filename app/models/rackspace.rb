# frozen_string_literal: true

class Rackspace < ApplicationRecord
  validates :name, :location, :unit_height, presence: true
  validates :unit_height, numericality: true

  has_many :rack_occupations, dependent: :restrict_with_error
  has_many :devices, through: :rack_occupations
end
