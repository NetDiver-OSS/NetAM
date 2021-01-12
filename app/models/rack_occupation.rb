# frozen_string_literal: true

class RackOccupation < ApplicationRecord
  belongs_to :cabinet
  belongs_to :device

  validates_with RackOccupationValidator
  validates :rack_anchor, presence: true
end
