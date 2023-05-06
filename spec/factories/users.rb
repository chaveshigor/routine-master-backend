# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 8) }

    trait :with_profile do
      after(:build) do |user|
        user.profile = create(:profile)
        user.profile.firstname = Faker::Name.first_name
        user.profile.lastname = Faker::Name.last_name
      end
    end
  end
end
