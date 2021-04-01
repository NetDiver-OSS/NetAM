# frozen_string_literal: true

class Whois < ApplicationRecord
  validates :domain, presence: true
end
