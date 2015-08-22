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
    task = Task.where(id: params[:id])
    if task.destroy!
      render json: { success: "task destroyed"}
    else
      render json: { errors: { card_id: "user id not found", id: "task id not found"} }, status: 422
    end
  end

  private
  def task_params
    params.require(:task).permit(:card_id, :title, :completed)
  end
end
