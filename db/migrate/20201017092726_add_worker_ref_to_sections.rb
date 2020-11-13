class AddWorkerRefToSections < ActiveRecord::Migration[6.0]
  def change
    add_reference :sections, :worker, null: true
  end
end
