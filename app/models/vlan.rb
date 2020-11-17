# frozen_string_literal: true

class Vlan < ApplicationRecord
  has_many :sections, dependent: :destroy

  validates_associated :sections
  validates :vid, :name, presence: true
  validates :vid, numericality: true
  validates :vid, uniqueness: true

  after_destroy do |vlan|
    Permission.where(subject_class: 'Vlan', subject_id: vlan.id).delete_all
  end
end
