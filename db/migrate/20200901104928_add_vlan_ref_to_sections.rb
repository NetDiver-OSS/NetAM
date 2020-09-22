class AddVlanRefToSections < ActiveRecord::Migration[6.0]
  def change
    add_reference :sections, :vlan, default: 1, foreign_key: true
  end
end
