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
    p token = request.env["HTTP_AUTH_TOKEN"] #=> returns the token
    p request.env["HTTP_NAME"] #=> returns the name
    p @user = User.find_by(name: request.env["HTTP_NAME"])
    p @user.auth_token
    p token == @user.auth_token
    if @user && @user.auth_token == token
    # if authenticate(user, token)
      true
    else
      render nothing: true, status: 401
    end
  end
  helper_method :signed_in?

  def authenticate(user, token)
    user.auth_token == decode(token)[0]
  end

  def encode(payload)
    self.rsa_private = OpenSSL::PKey::RSA.generate 2048
    self.rsa_public = rsa_private.public_key
    token = JWT.encode(payload, self.rsa_private, 'RS256')
  end

  def decode(token)
    decoded_token = JWT.decode(token, self.rsa_public)
  end
end
