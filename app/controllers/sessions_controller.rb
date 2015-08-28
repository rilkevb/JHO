class SessionsController < ApplicationController
  # include SessionsHelper

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      render json: { success: "session created, user logged in" }, status: 201, serializer: UserSerializer
    else
      render nothing: true, status: 401
    end
  end

  def destroy
    log_out if logged_in?
    render json: { success: "session destroyed, user logged out", }, status: 200
  end
end
