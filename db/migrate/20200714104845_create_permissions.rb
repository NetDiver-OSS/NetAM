class CreatePermissions < ActiveRecord::Migration[6.0]
  def change
    create_table :permissions do |t|
      t.string :name
      t.integer :user_id
      t.string :subject_class
      t.integer :subject_id
      t.string :action

      t.timestamps
    end
  end
end
