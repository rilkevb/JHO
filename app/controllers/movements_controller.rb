class MovementsController < ApplicationController
  def create
    card = Card.where(id: params[:card_id]).first
    # change card.list_id to the new list
    card.update(list_id: params[:card][:list_id])
    # create movement with the name of the card's now current list
    movement = Movement.new(card_id: card.id, current_list: card.list.name)

    if movement.save
      render json: movement, status: 200
    else
      render json: { errors:
                     {  current_list: "current_list parameter can't be blank and must contain 3 or more characters" }
                     }, status: 422
    end
  end

  def update
    movement = Movement.where(id: params[:id]).first
    if movement.update(current_list: params[:current_list],
                       card_id: params[:card_id])
      render json: movement, status: 200
    else
      render json: { errors:
                     { id: "movement with #{movement.id} could not be found",
                       current_list: "current_list parameter can't be blank and must contain 3 or more characters" }
                     }, status: 422
    end
  end

  def destroy
    movement = Movement.where(id: params[:id]).first
    if movement
      if movement.destroy
        render json: { success: "movement destroyed"}, status: 200
      else
        render json: { errors: "movement #{movement.id} not destroyed, possible callback error"}, status: 422
      end
    else
      render json: { errors: { card_id: "card id #{params[:card_id]} not found", id: "movement id #{params[:id]} not found"} }, status: 422
    end
  end

  private
  def movement_params
    # params.require(:movement).permit(:card_id, :current_list)
    # Not using require here because that wants movement to be included in params
    # Still need to investigate more about strong params, especially re:
    params.permit(:card_id, :current_list, :list_id)
  end

  # consider defining error messages here to provide dynamic ones and prevent tightly coupled tests
end
