require_relative('../helpers/responses_helper')
require_relative('../helpers/errors')
class V1::EmployeeController < ApplicationController
  def index
    @employees = Employee.all
    render json: { status: Status.success, data: @employees }, status: :ok
  end

  def create
    @employee = nil
    begin
      @employee = Employee.new(employees_param)
    rescue StandardError
      render json: { status: Status.failed, error: BODY_PARAMETRS }, status: :bad_request
    else
      if @employee.save
        render json: { status: Status.success, data: @employee }, status: :ok
      else
        begin
          @employee.save!
        rescue StandardError => e
          err = Error.new('Validation', 50, e.message)
          render json: { status: Status.failed, error: err }, status: :unprocessable_entity
        end
      end
    end
  end

  def update
    @employee = nil
    begin
      @employee = Employee.find(params[:id])
    rescue StandardError
      render json: { status: Status.failed, error: EMPLOYEE_NOT_FOUND }, status: :not_found
    else
      begin
        employees_param
      rescue StandardError
        render json: { status: Status.failed, error: BODY_PARAMETRS }, status: :bad_request
      else
        body_params = employees_param.to_h
        if body_params.size.zero?
          render json: {status: Status.failed, error: MISSING_REQUIRED_PARAMETRS}, status: :unauthorized
        elsif @employee.update(employees_param)
          render json: { status: Status.success, data: @employee }, status: :ok
        else
          begin
            @employee.update!
          rescue StandardError => e
            err = Error.new('Validation', 50, e.message)
            render json: { status: Status.failed, error: err }, status: :unprocessable_entity
          end
        end
      end
    end
  end

  def destroy
    @employee = nil
    begin
      @employee = Employee.find(params[:id])
    rescue StandardError
      render json: { status: Status.failed, error: EMPLOYEE_NOT_FOUND }, status: :not_found
    else
      begin
        @employee.destroy!
      rescue StandardError => e
        err = Error.new('Validation', 50, e.messsage)
        render json: { status: Status.failed, error: err }, status: :unprocessable_entity
      else
        render json: { status: Status.success, data: @employee }, status: :ok
      end
    end
  end

  private

  def employees_param
    params.require(:employee).permit(:name, :family_name, :birthday_date, :hiring_date, :photo_profile, :net_salary)
  end
end
