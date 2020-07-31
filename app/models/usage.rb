require 'csv'

class Usage < ApplicationRecord
  belongs_to :section

  enum state: %i[locked actived down dhcp]

  validates :state, :ip_used, presence: true
  validates :ip_used, uniqueness: { scope: :section, message: "should happen once per section" }

  # @param [int] section_id
  # @param [ActionDispatch::HTTP::UploadedFile] file
  def self.import(section_id, file)
    CSV.foreach(file.path, headers: true) do |row|
      Usage.create!(
        {
          section_id: section_id,
          ip_used: row['ip'],
          fqdn: row['hostname'].presence,
          state: row['state'].downcase.to_sym
        }
      )
    end
  end
end
