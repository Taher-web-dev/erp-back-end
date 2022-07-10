require_relative('../helpers/responses_helper')
require_relative('../helpers/errors')

class V1::SessionController < ApplicationController
    def create
      user = User.find_by(username: login_params['username'])

      if user && user.authenticate(login_params['password'])
        render json: { status: Status.success, data: user}, status: :ok
      else
        render json: { status: Status.failed, error: WRONG_CREDENTIALS}, status: :unauthorized
      end
    end
    
    private 
    def login_params
        params.permit(:username, :password)
    end
end
