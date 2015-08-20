class WelcomeController < ApplicationController
  def index
    if session[:user_id].nil?
      p "no session"
    else
      p "there's a session, redirecting to boards index"
      redirect_to boards_path
    end
  end
end
