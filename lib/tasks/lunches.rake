# frozen_string_literal: true

namespace :lunches do
  desc 'Generates faked employee data'
  task generate_six_months: :environment do
    year_and_months = (1..6).map do |n|
      past_year = Date.current.months_ago(n).year
      past_month = Date.current.months_ago(n).month
      [past_year, past_month]
    end.reverse

    year_and_months.each do |array|
      year = array[0]
      month = array[1]

      unless LunchPlan.exists_for_month?(year, month)
        CreateMysteryLunch
          .new(Employee.active, year: year, month: month)
          .make_new_lunch_plan
      end
    end
  end

  desc 'Destroy all employees without extra effects'
  task destroy_all: :environment do
    LunchParticipation.destroy_all
    Lunch.destroy_all
  end
end
