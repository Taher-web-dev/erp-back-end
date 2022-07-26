#require_relative('../helpers/responses_helper')
#require_relative('../helpers/errors')
class V1::UserController < ApplicationController
  Status = Helpers::ResponsesHelper::Status
  Error = Helpers::ResponsesHelper::Error
  Errors = Helpers::Errors
  def index
    @users = User.all
    render json: { status: Status.success, data: @users }, status: :ok
  end

  def create
    @user = nil
    begin
      @user = User.new(user_params)
    rescue StandardError
      render json: { status: Status.failed, error: Errors::BODY_PARAMETRS }, status: :bad_request
    else
      if @user.save
        render json: { status: Status.success, data: @user }, status: :ok
      else
        begin
          @user.save!
        rescue StandardError => e
          new_err = Error.new('Validation', 50, e.message)
          render json: { status: Status.failed, error: new_err }, status: :unprocessable_entity
        end
      end
    end
  end

  def update
    @user = nil
    begin
      @user = User.find(params[:id])
    rescue StandardError
      render json: { status: Status.failed, error: Errors::USER_NOT_FOUND }, status: :not_found
    else
      begin
        update_params
      rescue StandardError
        render json: { status: Status.failed, error: BODY_PARAMETRS }, status: :bad_request
      else
        body_params = update_params.to_h
        if body_params.size.zero?
          render json: { status: Status.failed, error: Errors::MISSING_REQUIRED_PARAMETRS }, status: :unauthorized
        elsif @user.update(body_params)
          render json: { status: Status.success, data: @user }, status: :ok
        else
          begin
            @user.update!(body_params)
          rescue StandardError => e
            err = Error.new('Validation', 50, e.message)
            render json: { status: Status.failed, error: err }, status: :unprocessable_entity
          end
        end
      end
    end
  end

  def destroy
    @user = nil
    begin
      @user = User.find(params[:id])
    rescue StandardError
      render json: { status: Status.failed, error: Errors::USER_NOT_FOUND }, status: :not_found
    else
      begin
        @user.destroy!
      rescue StandardError => e
        err = Error.new('Validation', 50, e.message)
        render json: { status: Status.failed, error: err }, status: :unprocessable_entity
      else
        render json: { status: Status.success, data: @user }, status: :ok
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :role, :employee_id)
  end

  def update_params
    params.permit(:username, :password, :role, :employee_id)
  end
end
