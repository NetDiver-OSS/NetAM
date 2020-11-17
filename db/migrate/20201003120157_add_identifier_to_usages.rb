# frozen_string_literal: true

class AddIdentifierToUsages < ActiveRecord::Migration[6.0]
  def change
    add_column :usages, :identifier, :string
    add_index :usages, :identifier, unique: true
  end
end
