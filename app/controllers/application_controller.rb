class ApplicationController < ActionController::API
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception

  private
  #assumes signed_in is called first
    def current_user
      ap "request" * 10
      ap request["headers"]
      ap request["rack_session"]
      ap request.headers["name"]
      p "USER" * 10
      p "user is"
      ap @current_user ||= User.find_by(name: request.headers["name"])
    end
    helper_method :current_user

    def signed_in?
     @user = User.find_by(name: request.headers["name"])
     if @user && @user.auth_token = request.headers["auth_token"]
       true
     else
       render nothing: true, status: 401
     end
    end
    helper_method :signed_in?
end
