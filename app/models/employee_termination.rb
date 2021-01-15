# frozen_string_literal: true

class EmployeeTermination
  def initialize(employee)
    @employee = employee
  end

  def execute
    @employee.update(deleted_at: Time.current)
  end
end
