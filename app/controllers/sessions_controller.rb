class SessionsController < ApplicationController

  before_action :signed_in?, except: [:create]

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # check if JWT received in request
      # if no JWT, generate JWT
      # if existing JWT, refresh JWT
      # return JWT in response
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
