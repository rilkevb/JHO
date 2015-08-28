module Api
  module V1
    class CardAssignmentsController < ApplicationController

      def create
        card_assignment = CardAssignment.new(card_assignment_params)
        if card_assignment.save
          render json: card_assignment, status: 201
        else
          render json:
          { errors: {
              user_id: "user_id can't be blank and must be a number",
            card_id: "card_id can't be blank and must be a number"}
            }, status: 422
        end
      end

      def update
        card_assignment = CardAssignment.where(id: params[:id]).first
        if card_assignment.update(card_assignment_params)
          render json: card_assignment, status: 200
        else
          render json:
          { errors: {
              user_id: "user_id can't be blank and must be a number",
            card_id: "card_id can't be blank and must be a number"}
            }, status: 422
        end
      end

      def destroy
        card_assignment = CardAssignment.where(id: params[:id]).first
        if card_assignment
          card_assignment.destroy
          render json: { success: "card assignment destroyed"}, status: 200
        else
          render json:
          { errors: {
            id: "card assignment #{params[:id]} not found, failed to destroy"}
            }, status: 422
        end
      end

      private
      def card_assignment_params
        params.require(:card_assignment).permit(:card_id, :user_id)
      end
    end
  end
end
