class Usage < ApplicationRecord
  belongs_to :section

  enum state: %i[locked actived down dhcp]

  validates :state, :ip_used, presence: true

  # @param [int] section_id
  # @param [ActionDispatch::HTTP::UploadedFile] file
  def self.import(section_id, file)
    CSV.foreach(file.path, headers: true) do |row|
      Usage.create!(
        {
          section_id: section_id,
          ip_used: row['ip'],
          state: row['state'].downcase.to_sym
        }
      )
    end
  end
end
