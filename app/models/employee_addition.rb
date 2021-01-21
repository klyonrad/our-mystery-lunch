# frozen_string_literal: true

class EmployeeAddition
  def initialize(employee)
    @employee = employee
  end

  def execute
    unless @employee.save
      return OpenStruct.new(
        success: false, employee: @employee
      )
    end

    extendable_lunches.sample.add_lunchee(@employee) if CurrentLunchPlan.new.already_created?
    OpenStruct.new(success: true, employee: @employee)
  end

  private

  def extendable_lunches
    CurrentLunchPlan.new.show_lunches.reject { |lunch| lunch.employees.size > 2 }
  end
end
