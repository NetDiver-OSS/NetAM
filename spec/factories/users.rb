# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { generate(:email) }
    password { Devise.friendly_token(20) }

    trait :admin do
      admin { true }
    end
  end
end
