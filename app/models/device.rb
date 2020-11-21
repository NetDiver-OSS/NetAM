# frozen_string_literal: true

class Device < ApplicationRecord
  belongs_to :device_type, optional: true
  delegate :name, to: :device_type, prefix: true, allow_nil: true

  validates :name, presence: true, uniqueness: true
end
