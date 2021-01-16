# frozen_string_literal: true

class ChangeUsagesStatusDefaultValue < ActiveRecord::Migration[6.0]
  def change
    execute <<-SQL.squish
      UPDATE usages
      SET state=1
      WHERE state=null
    SQL
    change_column :usages, :state, :integer, default: 1, null: false
  end
end
