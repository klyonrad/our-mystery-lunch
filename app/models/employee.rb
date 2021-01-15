# frozen_string_literal: true

class Employee < ApplicationRecord
  validates_presence_of :nick_name
  validates_presence_of :department

  scope :active, -> { where(deleted_at: nil) }
end
