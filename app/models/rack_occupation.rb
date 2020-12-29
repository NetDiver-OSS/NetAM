# frozen_string_literal: true

class RackOccupation < ApplicationRecord
  belongs_to :cabinet
  belongs_to :device
end
