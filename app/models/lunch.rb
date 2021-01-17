# frozen_string_literal: true

class Lunch < ApplicationRecord
  has_many :lunch_participations
  accepts_nested_attributes_for :lunch_participations

  def employees
    lunch_participations.map(&:employee)
  end
end
