class ApplicationController < ActionController::API
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  require 'auth_token'

  before_action :authenticate

  private

  def authenticate
    begin
      token = request.headers['Authorization'].split(' ').last
      p "token is #{token}"
      payload, header = AuthToken.valid?(token)
      p "payload is #{payload} and header is #{header}"
      p @current_user = User.find_by(id: payload['user_id'])
    rescue
      render json: { error: 'Authorization header not valid'}, status: :unauthorized
    end
  end
end
