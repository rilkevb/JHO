class TasksController < ApplicationController
  def index
    @tasks = Task.where(card_id: params[:card_id])
    render json: @tasks
  end

  def create
    task = Task.new(task_params)
    if task.save
      render json: task
    else
      render json: { error: "task not created"}
    end
  end

  def update
    task = Task.where(id: params[:id]).first
    if task.update(task_params)
      render json: task
    else
      render json: { error: "task not updated"}
    end
  end

  def destroy
    task = Task.where(id: params[:id])
    if task.destroy!
      render json: { success: "task destroyed"}
    else
      render json: { error: "task not destroyed"}
    end
  end

  private
  def task_params
    params.require(:task).permit(:card_id, :title, :completed)
  end
end
