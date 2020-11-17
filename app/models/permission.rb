# frozen_string_literal: true

class Permission < ApplicationRecord
  belongs_to :user

  delegate :email, to: :user, prefix: true

  validates :subject_class, :subject_id, :user, presence: true
end
