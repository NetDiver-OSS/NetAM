# frozen_string_literal: true

class Worker < ApplicationRecord
  has_many :sections

  validates :name, presence: true
end
