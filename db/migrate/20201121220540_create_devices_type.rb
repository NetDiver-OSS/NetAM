# frozen_string_literal: true

class CreateDevicesType < ActiveRecord::Migration[6.0]
  def change
    create_table :device_types do |t|
      t.string :name, null: false, uniqueness: true
      t.string :color, default: '#ffffff'

      t.timestamps
    end
  end
end
