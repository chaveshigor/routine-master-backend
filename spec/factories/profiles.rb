# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :profile do
    firstname { Faker::Name.first_name }
    lastname { Faker::Name.last_name }

    trait :with_user do
      after(:build) do |profile|
        profile.user = create(:user)
        profile.user.email = Faker::Internet.email
        profile.user.password = Faker::Internet.password(min_length: 8)
      end
    end
  end
end
