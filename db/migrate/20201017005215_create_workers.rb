# frozen_string_literal: true

class CreateWorkers < ActiveRecord::Migration[6.0]
  def change
    enable_extension 'uuid-ossp'
    create_table :workers do |t|
      t.string :name
      t.uuid :uuid, default: 'uuid_generate_v4()'

      t.timestamps
    end
  end
end
