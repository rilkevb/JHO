class UsersController < ApplicationController

  def create
    user = User.new(user_params)
    if user.save!
      render json: user
    else
      render json: { error: "user creation failed"}
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

  def user_params
    params.require(:user).permit(:name, :email, :password_hash, :password_digest, :location)
  end
end
