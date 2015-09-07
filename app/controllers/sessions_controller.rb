class SessionsController < ApplicationController

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      render json: user, status: 201, serializer: UserSerializer
    else
      render json: {
        errors: {
          email: "Your email address was incorrect or not recognized.",
          password: "Your password was incorrect or not recognized."
        }
      }, status: 422
    end
  end
end
