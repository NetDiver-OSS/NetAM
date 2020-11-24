# frozen_string_literal: true

class CreateDefaultDevicesTypes < ActiveRecord::Migration[6.0]
  def up
    DeviceType.create!({ name: 'None', color: '#ffffff' })
  end
end
