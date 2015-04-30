class CardsController < ApplicationController

  def show
    p params
    card = Card.find_by(id: params[:id])
    render json: card
  end

  def create
    card = Card.new(list_id: 1, organization_name: params[:organization_name])
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
    card.update_attributes(organization_name: params[:organization_name],
                            organization_summary: params[:organization_summary])
    render json: card
  end

  def destroy
  end

  private
  def card_params
    # params.require(:card).permit(:list_id, :organization_name)
    # need to add remaining attributes later. going for MVP now.
  end
end
