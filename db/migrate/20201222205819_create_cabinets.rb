class CreateCabinets < ActiveRecord::Migration[6.0]
  def change
    create_table :cabinets do |t|
      t.string :name
      t.integer :unit_height
      t.string :location

      t.timestamps
    end
  end
end
