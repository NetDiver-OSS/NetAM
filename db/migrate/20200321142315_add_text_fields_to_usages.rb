class AddTextFieldsToUsages < ActiveRecord::Migration[6.0]
  def change
    add_column :usages, :fqdn, :string
    add_index :usages, :fqdn
    add_column :usages, :description, :string
    add_index :usages, :description
    add_column :usages, :state, :integer
    add_index :usages, :state
  end
end
