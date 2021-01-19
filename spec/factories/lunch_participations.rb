# frozen_string_literal: true

FactoryBot.define do
  factory :lunch_participation do
    lunch
    employee
  end
end
