class ListsController < ApplicationController

  def create
    list = List.new(list_params)
    if list.save
      render json: list
    else
      render json: { error: "list failed to create"}
    end
  end

  def update
    # will want to add validation/error handling here
    list = List.find_by(id: params[:id])
    if list.update_attributes(list_params)
      render json: list
    else
      render json: { error: "list failed to update"}
    end
  end

  def destroy
    list = List.find(params[:id])
    if list.destroy!
      render json: { success: "list destroyed"}
    else
      render json: {error: "list was not destroyed"}
    end
  end

  private
  def list_params
    params.require(:list).permit(:board_id, :name, :position_id)
  end
end
