class Permission < ApplicationRecord
  belongs_to :user

  validates :subject_class, :subject_id, presence: true
end
