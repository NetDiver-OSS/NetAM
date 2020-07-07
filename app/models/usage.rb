class Usage < ApplicationRecord
  belongs_to :section

  enum state: [:locked, :actived, :down, :dhcp]
end
