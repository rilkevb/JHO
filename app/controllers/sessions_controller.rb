class SessionsController < ApplicationController

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      render json: user, status: 201, serializer: UserSerializer
    else
      render nothing: true, status: 401
    end
  end
end
