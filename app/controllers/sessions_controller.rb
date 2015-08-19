class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.where(email: params[:email]).first
    # would prefer a helper method like authenticate
    if user.password == params[:password_hash] && user.email == params[:email]
      session[:user_id] = user.id
    else
      render 'new'
    end
  end

  def destroy

  end
end
