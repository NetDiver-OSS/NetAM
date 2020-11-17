# frozen_string_literal: true

class RemoveTimestampsOnUsages < ActiveRecord::Migration[6.0]
  def change
    remove_column :usages, :created_at
    remove_column :usages, :updated_at
  end
end
