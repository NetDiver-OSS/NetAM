# frozen_string_literal: true

FactoryBot.define do
  sequence(:username) { |n| "user#{n}" }
  sequence(:name) { |n| "John Doe #{n}" }
  sequence(:email) { |n| "user#{n}@netam.org" }
  sequence(:vid) { |n| n }
end
