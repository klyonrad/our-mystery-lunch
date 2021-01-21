# frozen_string_literal: true

require 'faker'

class Employee < ApplicationRecord
  DEPARTMENTS = %w[operations sales marketing risk management finance HR development data].freeze

  has_many :lunch_participations
  has_many :lunches, through: :lunch_participations

  validates_presence_of :nick_name
  validates_presence_of :department

  scope :active, -> { where(deleted_at: nil) }

  def self.generate_fake
    DEPARTMENTS.without('management', 'sales').each do |department_name|
      rand(5..10).times do
        create(department: department_name, nick_name: Faker::FunnyName.unique.name)
      end
    end
    15.times do
      create(department: 'sales', nick_name: Faker::Name.unique.name)
    end

    rand(3..5).times do
      create(department: 'management', nick_name: Faker::DcComics.unique.hero)
    end
  end

  def lunched_with_recently?(other_employee)
    other_employee.in?(
      lunch_partners_since(Date.current.months_ago(3).beginning_of_month)
    )
  end

  private

  def lunch_partners_since(date)
    lunches_since(date)
      .map(&:employees).flatten.reject { |employee| employee == self }
  end

  def lunches_since(date)
    lunches.where(consumed_after: date..).includes(lunch_participations: :employee)
  end
end
