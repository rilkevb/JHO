class UsersController < ApplicationController
  include SessionsHelper

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      flash[:success] = "Welcome to JHO!"
      redirect_to boards_path
    else
      render 'new'
    end
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      render json: user
    else
      render json: { error: "user update failed"}
    end
  end

  def destroy
    user = User.find(params[:id])
    if user.destroy!
      render json: { success: "user destroyed"}
    else
      render json: { error: "user not destroyed"}
    end
  end


  private
  def user_params
    params.require(:user).permit(:name,
                                 :email,
                                 :password,
                                 :password_confirmation)
  end
end
