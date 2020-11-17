# frozen_string_literal: true

class CreateUsages < ActiveRecord::Migration[6.0]
  def change
    create_table :usages do |t|
      t.string :ip_used

      t.timestamps
    end
  end
end
