# frozen_string_literal: true

FactoryBot.define do
  factory :cabinet do
    name { generate(:name) }
    unit_height { generate(:vid) }
    location { 'home' }
  end
end
