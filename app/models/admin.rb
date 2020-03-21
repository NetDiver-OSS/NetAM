class Admin < ApplicationRecord
  devise :database_authenticatable, :rememberable, :validatable, :trackable
end
