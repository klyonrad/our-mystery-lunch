# frozen_string_literal: true

class Lunch < ApplicationRecord
  has_many :lunch_participations
end
