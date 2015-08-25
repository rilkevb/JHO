class ListsController < ApplicationController

  def create
    list = List.new(list_params)
    if list.save
      render json: list, status: 201
    else
      render json: { errors:
                     { name: "organization name can't be blank and must have 3 or more characters",
                       position_id: "position_id can't be blank and must be a number",
                       board_id: "board_id can't be blank and must be a number"}
                     }, status: 422
    end
  end

  def update
    list = List.where(id: params[:id]).first
    if list.update_attributes(list_params)
      render json: list, status: 200
    else
      render json: { errors:
                     { name: "organization name can't be blank and must have 3 or more characters",
                       position_id: "position_id can't be blank and must be a number",
                       board_id: "board_id can't be blank and must be a number"}
                     }, status: 422
    end
  end

  def destroy
    list = List.where(id: params[:id]).first
    if list
      list.destroy
      render json: { success: "list destroyed"}, status: 200
    else
      render json: { errors: {
                     id: "card #{params[:id]} not found, failed to destroy"}
                     }, status: 422
    end
  end

  private
  def list_params
    params.require(:list).permit(:board_id, :name, :position_id)
  end
end
