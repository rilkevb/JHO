class CardsController < ApplicationController

  # def show
  #   card = Card.find_by(id: params[:id])
  #   render json: card
  # end

  def create
    card = Card.new(card_params)
    if card.save
      render json: card
    else
      #Need to add validation to prevent nil card being created...
      render json: { error: "card failed to create"}
    end
  end

  def update
    # will want to add validation/error handling here
    card = Card.find_by(id: params[:id])
    if card.update_attributes(card_params)
      render json: card
    else
      render json: { error: "card failed to update"}
    end
  end

  def destroy
    card = Card.find(params[:id])
    if card.destroy!
      render json: { success: "card destroyed"}
    else
      render json: {error: "card was not destroyed"}
    end
  end

  private
  def card_params
    # which of these can we get rid of?
    params.require(:card).permit(:list_id, :organization_name, :organization_description, :position_description, :position_applied_for, :advocate, :tech_stack, :recent_articles, :glassdoor_rating, :title, :description)
  end
end
