class MovementsController < ApplicationController
  def create
    card = Card.find_by(params[:id])
    if card.save
      movement = card.movements.new(current_list: params[:list_id],
                                    card_id: card.id)
      if movement.save
        render nothing: true
      else
        render json: { error: "movement not created"}
      end
    else
      render json: { error: "card failed to save"}
    end
  end
end
