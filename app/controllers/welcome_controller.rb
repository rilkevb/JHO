class WelcomeController < ApplicationController
  def index
    if session[:user_id].nil?
      p "no session"
    else
      p "session exists"
    end
  end
end
