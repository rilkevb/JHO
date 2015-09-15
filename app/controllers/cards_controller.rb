class CardsController < ApplicationController

  def today
    # fetch highest priority cards from all lists
    # this much method chaining seems like it wants some refactoring
    cards = []
    @current_user.boards.first.lists.map do |list|
      if list.cards.empty?
        next
      else
        cards << list.cards
      end
    end
    p cards.flatten!
    # using #sort_by and #take because you get an array from each

    prioritized_cards = cards.sort_by(&:priority)#.sort_by(&:updated_at)
    todays_cards = prioritized_cards.take(7)
    render json: todays_cards, status: 200
  end

  # def show
  #   card = Card.find_by(id: params[:id])
  #   render json: card
  # end

  def create
    card = Card.new(card_params)
    if card.save
      render json: card, status: 201
    else
      render json: { errors:
                     { organization_name: "organization_name can't be blank and must have 3 or more characters "}
                     }, status: 422
    end
  end

  def update
    card = Card.where(id: params[:id]).first
    if card.update_attributes(card_params)
      render json: card, status: 200
    else
      render json: { errors: {id: "card #{params[:id]} not found, failed to update",
                              organization_name: "organization_name can't be blank and must have 3 or more characters "}
                     }, status: 422
    end
  end

  def destroy
    card = Card.where(id: params[:id]).first
    if card
      card.destroy
      render json: { success: "card destroyed"}, status: 200
    else
      render json: {errors: {
                    id: "card #{params[:id]} not found, failed to destroy"}
                    }, status: 422
    end
  end

  private
  def card_params
    # which of these can we get rid of?
    params.require(:card).permit(:list_id, :organization_name, :organization_summary, :position_description, :position_applied_for, :advocate, :tech_stack, :recent_articles, :glassdoor_rating, :title, :description, :points, :priority, :next_task, :archived)
  end
end
