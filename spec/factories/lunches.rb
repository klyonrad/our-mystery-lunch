# frozen_string_literal: true

FactoryBot.define do
  factory :lunch do
    consumed_after { '2021-01-17 21:21:59' }

    trait :with_two_participants do
      lunch_participations do
        Array.new(2) { association(:lunch_participation) }
      end
    end
  end
end
