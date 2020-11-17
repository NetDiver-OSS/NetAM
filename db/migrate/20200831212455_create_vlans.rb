# frozen_string_literal: true

class CreateVlans < ActiveRecord::Migration[6.0]
  def change
    create_table :vlans do |t|
      t.integer :vid
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
