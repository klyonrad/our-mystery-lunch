# frozen_string_literal: true

class EmployeesController < ApplicationController
  before_action :set_employee, only: %i[show edit update destroy]

  # GET /employees
  def index
    @employees = Employee.active
  end

  # GET /employees/1
  def show; end

  # GET /employees/new
  def new
    @employee = Employee.new
  end

  # GET /employees/1/edit
  def edit; end

  # POST /employees
  def create
    @employee = Employee.new(employee_params)
    add_process_result = EmployeeAddition.new(@employee).execute
    @employee = add_process_result.employee
    if add_process_result.success
      redirect_to @employee, notice: 'Employee was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /employees/1
  def update
    if @employee.update(employee_params)
      redirect_to @employee, notice: 'Employee was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /employees/1
  def destroy
    EmployeeTermination.new(@employee).execute
    redirect_to employees_url, notice: 'Employee was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_employee
    @employee = Employee.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def employee_params
    params.require(:employee).permit(:nick_name, :department)
  end
end
