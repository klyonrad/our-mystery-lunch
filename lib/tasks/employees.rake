# frozen_string_literal: true

require 'faker'

namespace :employees do
  desc 'Generates faked employee data'
  task generate_fake: :environment do
    Employee::DEPARTMENTS.without('management').each do |department_name|
      rand(5..20).times do
        Employee.create(department: department_name, nick_name: Faker::FunnyName.unique.name)
      end
    end

    rand(3..5).times do
      Employee.create(department: 'management', nick_name: Faker::DcComics.unique.hero)
    end
  end
end
