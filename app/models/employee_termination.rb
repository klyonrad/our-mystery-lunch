# frozen_string_literal: true

class EmployeeTermination
  def initialize(employee)
    @employee = employee
  end

  def execute
    @employee.update(deleted_at: Time.current)
    return unless relevant_lunch_participation

    relevant_lunch_participation.destroy if relevant_lunch_participation.lunch.current_month?
  end

  private

  def relevant_lunch_participation
    @employee.lunch_participations.last
  end
end
