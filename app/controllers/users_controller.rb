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
      render 'new', status: 422
    end
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      render json: user
    else
      render json: { error: "user update failed"}
      # render 'edit'
    end
  end

  def destroy
    user = User.where(id: params[:id]).first
    if user
      user.destroy!
      render json: { success: { message: "user destroyed" }
                     }, status: 200
    else
      render json: { errors: { user_id: "user id not found"} }, status: 422
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
