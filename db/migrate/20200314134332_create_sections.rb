class CreateSections < ActiveRecord::Migration[6.0]
  def change
    create_table :sections do |t|
      t.string :name
      t.text :description
      t.string :network

      t.timestamps
    end
  end
end
