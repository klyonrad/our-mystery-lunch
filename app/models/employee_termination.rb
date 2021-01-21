# frozen_string_literal: true

class EmployeeTermination
  def initialize(employee)
    @employee = employee
  end

  def execute
    @employee.update(deleted_at: Time.current)
    return unless relevant_lunch_participation
    return unless relevant_lunch.current_month?

    relevant_lunch_participation.destroy
    return if relevant_lunch.reload.lunch_participations.size > 1

    remaining_employee = relevant_lunch.employees.first
    relevant_lunch.destroy
    extendable_lunches.sample.add_lunchee(remaining_employee)
  end

  private

  def relevant_lunch_participation
    @employee.lunch_participations.last
  end

  def relevant_lunch
    @relevant_lunch ||= relevant_lunch_participation.lunch
  end

  def extendable_lunches
    CurrentLunchPlan.new.show_lunches.reject { |lunch| lunch.employees.size > 2 }
  end
end
