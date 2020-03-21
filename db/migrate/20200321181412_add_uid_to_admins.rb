class AddUidToAdmins < ActiveRecord::Migration[6.0]
  def change
    add_column :admins, :uid, :string
    add_index :admins, :uid, unique: true
  end
end
