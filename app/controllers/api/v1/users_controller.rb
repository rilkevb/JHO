module Api
  module V1
    class UsersController < ApplicationController

      before_action :signed_in?, only: [:update]

      def create
        user = User.create(user_params)
        if user.save
          render json: user, status: 201, serializer: UserSerializer
        else
          render json: {
            errors: {
              id: "used #{params[:id]} not found, failed to update",
              name: "user name can't be blank or must contain 3 or more characters",
              email: "email can't be blank and must be a valid format e.g., test@example.com",
              password: "password must be at least 6 characters and can't be blank",
              password_confirmation: "password confirmation can't be blank and must match password"
            }
          }, status: 422
        end
      end

      def update
        if current_user.update(user_params)
          render json: current_user, status: 200, serializer: UserSerializer
        else
          render json: {
            errors: {
              id: "used #{params[:id]} not found, failed to update",
              name: "user name can't be blank or must contain 3 or more characters",
              email: "email can't be blank and must be a valid format e.g., test@example.com",
              password: "password must be at least 6 characters and can't be blank",
              password_confirmation: "password confirmation can't be blank and must match password"
            }
          }, status: 422
        end
      end

      def destroy
        user = User.where(id: params[:id]).first
        if user
          user.destroy
          render json: { success: { message: "user destroyed" }
                         }, status: 200
        else
          render json: { errors: { id: "user #{params[:id]} not found"} }, status: 422
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
  end
end
