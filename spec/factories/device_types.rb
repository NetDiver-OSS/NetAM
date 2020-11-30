# frozen_string_literal: true

FactoryBot.define do
  factory :device_type do
    name { generate(:name) }
    color { '#ff00ff' }
  end
end
