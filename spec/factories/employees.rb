# frozen_string_literal: true

FactoryBot.define do
  factory :employee do
    nick_name { "MyString" }
    department { "MyString" }
    deleted_at { nil }
  end
end
