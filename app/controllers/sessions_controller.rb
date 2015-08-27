class SessionsController < ApplicationController
  include SessionsHelper

  def create
    @user = User.new
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to boards_path
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    render json: { success: "session destroyed, user logged out", }, status: 200
  end
end
