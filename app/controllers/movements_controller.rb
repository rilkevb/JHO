class MovementsController < ApplicationController
  def create
    # create movement with the name of the card's now current list
    movement = Movement.new(card_id: params[:card_id], current_list: card.list.name)
    card = Card.where(id: params[:card_id]).first

    if card && movement.save
      # change card.list_id to the new list
      card.update(list_id: params[:card][:list_id])
      # set priority score based on the card's new list
      card.recalculate_priority
      # assign next task based on card's list & other completed tasks
      card.set_next_task
      render json: { movement: movement, card: card } , status: 200
    else
      render json: { errors:
                     {  card_id: "card with card_id #{card_id} could not be found",
                        current_list: "current_list parameter can't be blank and must contain 3 or more characters" }
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
    params.permit(:card_id, :current_list, :list_id)
    # params.require(:movement).permit(:card_id, :current_list, :list_id)
  end

  # consider defining error messages here to provide dynamic ones and prevent tightly coupled tests
end
