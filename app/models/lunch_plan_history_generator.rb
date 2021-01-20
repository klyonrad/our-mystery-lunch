# frozen_string_literal: true

class LunchPlanHistoryGenerator
  def execute
    year_and_months = (1..6).map do |n|
      past_year = Date.current.months_ago(n).year
      past_month = Date.current.months_ago(n).month
      [past_year, past_month]
    end.reverse

    year_and_months.each do |array|
      year = array[0]
      month = array[1]

      next if LunchPlan.exists_for_month?(year, month)

      CreateMysteryLunch
        .new(Employee.active, year: year, month: month)
        .make_new_lunch_plan
    end
  end
end
