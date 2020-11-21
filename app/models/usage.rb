# frozen_string_literal: true

require 'csv'

class Usage < ApplicationRecord
  after_initialize :init

  enum state: { locked: 0, actived: 1, down: 2, dhcp: 3 }

  belongs_to :section
  belongs_to :device

  validates :section, presence: true
  validates :state, :ip_used, :identifier, presence: true
  validates :ip_used, uniqueness: { scope: :section, message: 'should happen once per section' }

  def init
    self.identifier = "#{id}_#{ip_used}"
  end

  # @param [int] section_id
  # @param [ActionDispatch::HTTP::UploadedFile] file
  #
  def self.import(section_id, file)
    CSV.foreach(file.path, headers: true) do |row|
      Usage.create(
        {
          section_id: section_id,
          ip_used: row['ip'],
          fqdn: row['hostname'].presence,
          description: row['description'].presence,
          state: row['state'].downcase.to_sym
        }
      )
    end
  end
end
