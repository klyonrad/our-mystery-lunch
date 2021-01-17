# frozen_string_literal: true

class Employee < ApplicationRecord
  DEPARTMENTS = %w[operations sales marketing risk management finance HR development data].freeze

  validates_presence_of :nick_name
  validates_presence_of :department

  scope :active, -> { where(deleted_at: nil) }
end
