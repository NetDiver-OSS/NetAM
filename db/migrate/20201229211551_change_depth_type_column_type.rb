# frozen_string_literal: true

class ChangeDepthTypeColumnType < ActiveRecord::Migration[6.0]
  def change
    change_column :devices, :depth_type, :integer, using: 'depth_type::integer', default: 1
  end
end
