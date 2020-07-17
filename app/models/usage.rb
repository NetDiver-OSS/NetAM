class Usage < ApplicationRecord
  belongs_to :section

  enum state: %i[locked actived down dhcp]

  validates :state, :ip_used, presence: true
end
