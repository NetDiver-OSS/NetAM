# frozen_string_literal: true

FactoryBot.define do
  factory :vlan do
    name { generate(:name) }
    vid { generate(:vid) }
  end
end
