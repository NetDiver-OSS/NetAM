class CreateDefaultVlan < ActiveRecord::Migration[6.0]
  def up
    Vlan.create!({name: "default", description: "Default Vlan.", vid: 1})
  end
end
