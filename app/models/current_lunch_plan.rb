# frozen_string_literal: true

class CurrentLunchPlan
  def initialize(lunch_repo: LunchPlan, random_lunch_generator: CreateMysteryLunch)
    timestamp = Time.current
    @year = timestamp.year
    @month = timestamp.month
    @lunch_repo = lunch_repo
    @random_lunch_generator_klass = random_lunch_generator
  end

  # @return [Lunch]
  def view_or_create
    generate_new_plan unless already_created?
    show_lunches
  end

  def already_created?
    @lunch_repo.exists_for_month?(@year, @month)
  end

  private

  def show_lunches
    @lunch_repo.lunches_in_month(@year, @month)
  end

  def generate_new_plan
    @random_lunch_generator_klass.new(Employee.active).make_new_lunch_plan
  end
end
