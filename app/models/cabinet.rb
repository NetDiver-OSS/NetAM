# frozen_string_literal: true

class Cabinet < ApplicationRecord
  validates :name, :location, :unit_height, presence: true
  validates :unit_height, numericality: true
end
