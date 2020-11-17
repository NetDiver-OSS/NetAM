# frozen_string_literal: true

class AddScheduleToSections < ActiveRecord::Migration[6.0]
  def change
    add_column :sections, :schedule, :string
  end
end
