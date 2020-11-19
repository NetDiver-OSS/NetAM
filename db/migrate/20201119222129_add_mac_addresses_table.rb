# frozen_string_literal: true

class AddMacAddressesTable < ActiveRecord::Migration[6.0]
  def change
    create_table :mac_addresses, id: false do |t|
      t.string :mac
      t.string :vendor

      t.timestamps
    end
  end
end
