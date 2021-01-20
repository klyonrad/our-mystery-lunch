# frozen_string_literal: true

require 'faker'

namespace :employees do
  desc 'Generates faked employee data'
  task generate_fake: :environment do
    Employee::DEPARTMENTS.without('management', 'sales').each do |department_name|
      rand(5..10).times do
        Employee.create(department: department_name, nick_name: Faker::FunnyName.unique.name)
      end
    end
    15.times do
      Employee.create(department: 'sales', nick_name: Faker::Name.unique.name)
    end

    rand(3..5).times do
      Employee.create(department: 'management', nick_name: Faker::DcComics.unique.hero)
    end
  end

  desc 'Destroy all employees without extra effects'
  task destroy_all: :environment do
    Employee.destroy_all
  end
end
