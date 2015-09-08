class SessionsController < ApplicationController

  before_action :authenticate, except: [:create]

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # generate JWT, "logging in" user
      token = AuthToken.issue_token({ user_id: user.id })
      # return JWT in response
      render json: { user: user,
                     token: token }, status: 201, serializer: UserSerializer
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
