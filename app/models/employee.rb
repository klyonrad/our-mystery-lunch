# frozen_string_literal: true

class Employee < ApplicationRecord
  validates_presence_of :nick_name
  validates_presence_of :department
end
