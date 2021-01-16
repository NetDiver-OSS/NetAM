# frozen_string_literal: true

FactoryBot.define do
  factory :rackspace do
    name { generate(:name) }
    unit_height { generate(:vid) }
    location { 'home' }
  end
end
