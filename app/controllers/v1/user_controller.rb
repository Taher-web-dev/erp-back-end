require_relative('./responses_helper')
require_relative('./errors')
class V1::UserController < ApplicationController
  def index
    @users = nil
    begin
      @users = User.all
    rescue StandardError
      render json: { status: Status.failed, error: USER_NOT_FOUND }, status: :unprocessable_entity
    else
      render json: { status: Status.success, data: @users }, status: :ok
    end
  end

  def create
    @user = nil
    begin
      @user = User.new(user_params)
    rescue
      render json: { status: Status.failed, error: BODY_PARAMETRS }, status: :unprocessable_entity
    else
      if @user.save
        render json: { status: Status.success, data: @user }, status: :ok
      else
        render json: { status: Status.failed, error: MISSING_REQUIRED_PARAMETRS }, status: :bad_request
      end
    end
  end

  def update
    @user = nil
    begin
      @user = User.find(params[:id])
    rescue
      render json: { status: Status.failed, error: USER_NOT_FOUND }, status: :not_found
    else
      body_params = user_params.to_h
      if body_params.size == 0
        render json: { status: Status.failed, error: MISSING_REQUIRED_PARAMETRS }, status: :unauthorized
      elsif @user.update(user_params)
        render json: { status: Status.success, data: @user }, status: :ok
      else
        render json: { status: Status.failed, error: @user.errors }, status: :unprocessable_entity
      end
    end
  end

  def destroy
    @user = nil
    begin
      @user = User.find(params[:id])
    rescue StandardError
      render json: { status: Status.failed, error: USER_NOT_FOUND }, status: :unprocessable_entity
    else
      if @user.destroy
        render json: { status: Status.success, data: @user }, status: :ok
      else
        render json: { status: Status.failed, error: @user.errors }, status: :unprocessable_entity
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:Full_name, :username, :password, :role)
  end
end
