# frozen_string_literal: true

namespace :lunches do
  desc 'Generates faked employee data'
  task generate_six_months: :environment do
    LunchPlanHistoryGenerator.new.execute
  end

  desc 'Destroy all employees without extra effects'
  task destroy_all: :environment do
    LunchParticipation.destroy_all
    Lunch.destroy_all
  end
end
