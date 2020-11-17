# frozen_string_literal: true

FactoryBot.define do
  factory :section do
    name { generate(:name) }
    network { '10.0.0.0/24' }
    schedule { 'every 24h' }

    vlan
  end
end
