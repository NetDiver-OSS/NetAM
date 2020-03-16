class AddSectionRefToUsages < ActiveRecord::Migration[6.0]
  def change
    add_reference :usages, :section, null: false, foreign_key: true
  end
end
