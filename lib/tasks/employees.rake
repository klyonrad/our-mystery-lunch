# frozen_string_literal: true

require 'faker'

namespace :employees do
  desc 'Generates faked employee data'
  task generate_fake: :environment do
    Employee.generate_fake
  end

  desc 'Destroy all employees without extra effects'
  task destroy_all: :environment do
    Employee.destroy_all
  end
end
