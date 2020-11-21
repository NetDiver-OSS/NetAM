class AddRefDevicesTypeToDevices < ActiveRecord::Migration[6.0]
  def change
    add_reference :devices, :devices_type, null: true, foreign_key: true
  end
end
