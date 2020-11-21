class AddRefDevicesToUsages < ActiveRecord::Migration[6.0]
  def change
    add_reference :usages, :devices, null: true, foreign_key: true
  end
end
