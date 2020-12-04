# frozen_string_literal: true

class DeviceType < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  before_destroy do |dt|
    throw(:abort) if dt.name == 'None'
  end
end
