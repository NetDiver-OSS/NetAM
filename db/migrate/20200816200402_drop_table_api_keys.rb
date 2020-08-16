class DropTableAPIKeys < ActiveRecord::Migration[6.0]
  def change
    drop_table :api_keys
  end
end
