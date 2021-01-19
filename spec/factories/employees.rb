# frozen_string_literal: true

FactoryBot.define do
  factory :employee do
    sequence(:nick_name) { |n| "John Doe #{n}" }
    department { "MyString" }
    deleted_at { nil }
  end
end
