# frozen_string_literal: true

class CreateDevices < ActiveRecord::Migration[6.0]
  def change
    create_table :devices do |t|
      t.string :name, null: false, uniqueness: true
      t.integer :h_size, null: true
      t.integer :p_size, null: true

      t.timestamps
    end
    add_reference :devices, :usages, null: true, foreign_key: true
  end
end
