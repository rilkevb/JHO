module Api
  module V1
    class TasksController < ApplicationController
      def index
        @tasks = Task.where(card_id: params[:card_id])
        render json: @tasks
      end

      def create
        task = Task.new(task_params)
        if task.save
          render json: task, status: 200
        else
          render json: { errors: {title: "Title can't be blank and must be a minimum of 3 characters"} }, status: 422
        end
      end

      def update
        task = Task.where(id: params[:id]).first
        if task.update(task_params)
          render json: task
        else
          render json: { errors: {title: "Title can't be blank and must be a minimum of 3 characters"} }, status: 422
        end
      end

      def destroy
        task = Task.where(id: params[:id]).first
        if task
          if task.destroy
            render json: { success: "task destroyed"}, status: 200
          else
            render json: { errors: "task #{task.id} not destroyed, possible callback error"}, status: 422
          end
        else
          render json: { errors: { card_id: "task id #{params[:card_id]} not found", id: "task id #{params[:id]} not found"} }, status: 422
        end
      end

      private
      def task_params
        # params.require(:task).permit(:card_id, :title, :completed)
        # Not using require here because that wants movement to be included in params
        # Still need to investigate more about strong params, especially re: testing
        params.permit(:card_id, :title, :completed)
      end
    end
  end
end
