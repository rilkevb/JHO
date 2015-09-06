class ApplicationController < ActionController::API
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception

  before_action :signed_in?

  private
  #assumes signed_in is called first
  def current_user
    @current_user ||= User.find_by(name: request.headers["name"])
  end
  helper_method :current_user

  def signed_in?
    received_token = request.env["HTTP_AUTH_TOKEN"] #=> returns the token
    #request.env["HTTP_NAME"] #=> returns the name
    @user = User.find_by(name: request.env["HTTP_NAME"])
    if @user && @user.auth_token == received_token
      true
    else
      render nothing: true, status: 401
    end
  end
  helper_method :signed_in?

  # def authenticate
  #   decode_token
  #   verify_token
  # end

  # def verify_token
  #   # https://github.com/jwt/ruby-jwt
  # end

  # def decode_token
  #   # https://github.com/jwt/ruby-jwt
  # end
end
