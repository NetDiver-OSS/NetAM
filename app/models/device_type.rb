# frozen_string_literal: true

class DeviceType < ApplicationRecord
  validates :name, presence: true
end
