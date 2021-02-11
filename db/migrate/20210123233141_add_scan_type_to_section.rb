# frozen_string_literal: true

class AddScanTypeToSection < ActiveRecord::Migration[6.0]
  def change
    add_column :sections, :scan_type, :string, default: 'ping'
  end

  def up
    Section.all.each { |section| section.update!(scan_type: 'ping') }
  end
end
