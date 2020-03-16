class Section < ApplicationRecord
  has_many :usages, dependent: :destroy
end
