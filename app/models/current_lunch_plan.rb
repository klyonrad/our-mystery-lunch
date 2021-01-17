# frozen_string_literal: true

class CurrentLunchPlan
  def initialize
    timestamp = Time.current
    @year = timestamp.year
    @month = timestamp.month
  end

  def view_or_create
    generate_new_plan unless already_created?
    show_lunches
  end

  def already_created?
    LunchPlan.exists_for_month?(@year, @month)
  end

  private

  def show_lunches
    'Here is the mystery lunch plan!'
  end

  def generate_new_plan
    puts 'Generating....'
  end
end
