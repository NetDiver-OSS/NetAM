# frozen_string_literal: true

class CreateRackspaces < ActiveRecord::Migration[6.0]
  def change
    create_table :rackspaces do |t|
      t.string :name
      t.integer :unit_height
      t.string :location

      t.timestamps
    end
  end
end
