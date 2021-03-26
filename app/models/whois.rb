# frozen_string_literal: true

class Whois < ApplicationRecord
  validates :ip, presence: true
end
