# frozen_string_literal: true

class AddRefDevicesToUsages < ActiveRecord::Migration[6.0]
  def change
    add_reference :usages, :device, null: true, foreign_key: true
  end
end
