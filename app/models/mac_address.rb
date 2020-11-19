# frozen_string_literal: true

class MacAddress < ApplicationRecord
  validates :mac, :vendor, presence: true
end
