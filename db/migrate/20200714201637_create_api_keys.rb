# frozen_string_literal: true

class CreateAPIKeys < ActiveRecord::Migration[6.0]
  def change
    create_table :api_keys do |t|
      t.string :access_token
      t.datetime :expires_at
      t.integer :user_id
      t.boolean :active

      t.timestamps
    end

    add_index :api_keys, :user_id, unique: false
    add_index :api_keys, :access_token, unique: true
  end
end
