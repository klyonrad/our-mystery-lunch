# frozen_string_literal: true

class LunchParticipation < ApplicationRecord
  belongs_to :lunch
  belongs_to :employee
end
