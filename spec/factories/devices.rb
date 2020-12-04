# frozen_string_literal: true

FactoryBot.define do
  factory :device do
    name { generate(:name) }

    device_type
  end
end
