# frozen_string_literal: true

class CreateRackOccupations < ActiveRecord::Migration[6.0]
  def change
    create_table :rack_occupations do |t|
      t.belongs_to :rackspace
      t.belongs_to :device
      t.integer :rack_anchor

      t.timestamps
    end
  end
end
