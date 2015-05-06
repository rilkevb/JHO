class MovementsController < ApplicationController

  def create
    # p "*="*50
    # p params
    # p data
    card = Card.find(params[:card_id])  #we have to access the card_id, also this was an incorrect usage of find_by!
    # p "We are looking at"
    # p card.organization_name
    card.update_attributes(list_id: params[:list_id])
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
