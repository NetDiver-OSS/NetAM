# frozen_string_literal: true

class UpdateIdentifierForUsages < ActiveRecord::Migration[6.0]
  def change
    Usage.where(identifier: nil).each do |usage|
      usage.identifier = "#{usage.section_id}_#{usage.ip_used}"
      usage.save!
    end
  end
end
