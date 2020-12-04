# frozen_string_literal: true

class Device < ApplicationRecord
  belongs_to :device_type, optional: true
  delegate :name, :color, to: :device_type, prefix: true, allow_nil: true

  has_one :usage, dependent: :nullify

  enum depth_type: { small: 'small', half: 'half', full: 'full' }

  validates :name, presence: true, uniqueness: true
end
