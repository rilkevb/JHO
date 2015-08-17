class MovementsController < ApplicationController
  def create
    card = Card.find_by(params[:card_id])
    # Where is this list_id in params coming?
    card.update_attributes(list_id: params[:list_id])
    if card.save
      movement = card.movements.new(current_list: card.list.name,
                                    card_id: card.id)
      if movement.save
        render json: { success: "movement created" }
      else
        render json: { error: "movement not created"}
      end
    else
      render json: { error: "card failed to save"}
    end
  end

  def update
    movement = Movement.where(id: params[:id]).first
    if movement.update(current_list: params[:current_list],
                       card_id: params[:card_id])
      render json: { success: "movement update" }
    else
      render json: { error: "movement not update"}
    end
  end

  def destroy
    movement = Movement.where(id: params[:id])
    if movement.destroy!
      render json: { success: "movement destroyed"}
    else
      render json: { error: "movement not destroyed"}
    end
  end

  private
  def movement_params
    params.require(:movement).permit(:card_id, :current_list)
  end
end
