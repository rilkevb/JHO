class CardsController < ApplicationController
  def create
    p params
    # @card = Card.new(card_params)
    @card = Card.new(list_id: params[:list_id], organization_name: params[:organization_name])
    if @card.save
      render json: @card
    else
      render json: { error: "card failed to create"}
    end
  end

  def destroy
  end

  private
  def card_params
    # params.require(:card).permit(:list_id, :organization_name)
    # need to add remaining attributes later. going for MVP now.
  end
end
