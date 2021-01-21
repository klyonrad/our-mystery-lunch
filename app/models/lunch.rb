# frozen_string_literal: true

class Lunch < ApplicationRecord
  has_many :lunch_participations
  accepts_nested_attributes_for :lunch_participations

  validates_presence_of :consumed_after

  def employees
    lunch_participations.map(&:employee)
  end

  def employees_text
    employees.map do |employee|
      "#{employee.nick_name} (#{employee.department})"
    end.join(', ')
  end

  def add_lunchee(new_lunchee)
    lunch_participations.create(employee: new_lunchee)
  end
end
