class CardsController < ApplicationController
  def create
    # p "*="*50
    # p "PARAMS ARE: "
    # p params
    # p "params[:organization_name]: "
    # p params[:organization_name]
    # @card = Card.new(card_params)
    @card = Card.new(list_id: 1, organization_name: params[:organization_name])
    if @card.save
      render json: @card
    else
      #Need to add validation to prevent nill card being created...
      render json: { error: "card failed to create"}
    end
  end

  def update
    @card = Card.find_by(id: params[:card_id])
    @card.list_id = params[:list_id]
    if @card.save
      @movement = @card.movements.new(current_list: params[:list_id], card_id: @card.id)
      if @movement.save
        render nothing: true
      else
        # movement fail
      end
    else
      # card save fail
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
