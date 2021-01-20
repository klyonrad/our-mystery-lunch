# frozen_string_literal: true

# Serves as repository
class LunchPlan
  def self.lunches_in_month(year, month)
    Lunch.includes(lunch_participations: :employee)
         .where(consumed_after: Date.new(year, month)..Date.new(year, month).end_of_month)
  end

  def self.exists_for_month?(year, month)
    Lunch.where(consumed_after: Date.new(year, month)..Date.new(year, month).end_of_month).any?
  end

  def self.past_lunches
    (1..6).map do |n|
      past_year = Date.current.months_ago(n).year
      past_month = Date.current.months_ago(n).month
      OpenStruct.new(
        months_ago: n,
        lunch_plan: lunches_in_month(past_year, past_month)
      )
    end.reverse
  end

  # @param [Lunch] lunches - In memory lunch objects, hopefully with their participants :)
  def self.store_lunch_plan(lunches)
    Lunch.transaction do
      lunches.each(&:save!)
    end
  end
end
