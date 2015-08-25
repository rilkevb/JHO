class WelcomeController < ApplicationController
  def index
    if session[:user_id].nil?
      render :index
    else
      redirect_to boards_path
    end
  end
end
