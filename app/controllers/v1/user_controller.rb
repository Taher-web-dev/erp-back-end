require_relative('./ApiExceptions.rb')
require_relative('./Errors.rb')
class V1::UserController < ApplicationController
  def index
    @users
    begin
      @users = User.all
    rescue
      render json: {status:Status.failed, error: USER_NOT_FOUND}, status: :unprocessable_entity
    else
      render json: {status: Status.success, data:@users}, status: :ok
    end
  end

  def create
    begin
      @user = User.new(user_params)
    rescue
      render json: {status: Status.failed, error: BODY_PARAMETRS}, status: :unprocessable_entity
    else
      if @user.save
        render json: {status: Status.success, data: @user}, status: :ok
      else
        render json: {status: Status.failed, error: @user.errors}, status: :unprocessable_entity
      end
    end
  end
  def update
    @user
    begin
      @user=User.find(params[:id])
    rescue
      render json: {status: Status.failed, error: USER_NOT_FOUND}
    else
      if @user.update(user_params)
        render json: {status: Status.success, data:@user}
      else
        render json: {status: Status.failed, error:@user.errors}
      end
    end
  end

  def destroy
    @user
    begin
      @user = User.find(params[:id])
    rescue
      render json: {status: Status.failed,error: USER_NOT_FOUND}
    
    else 
      if @user.destroy
      render json: {status: Status.success, data:@user}
      else
      render json: {status: Status.failed, error: @user.errors}
      end
    end
  end
  private
  def user_params
    params.require(:user).permit(:Full_name, :username, :password, :role)
  end
end
