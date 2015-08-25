class BoardMembersController < ApplicationController

  def create
    board_member = BoardMember.new(board_member_params)
    if board_member.save
      render json: board_member, status: 201
    else
      render json:
      { errors: {
          user_id: "user_id can't be blank and must be a number",
        card_id: "board_id can't be blank and must be a number"}
        }, status: 422
    end
  end

  def update
    board_member = BoardMember.where(id: params[:id]).first
    if board_member.update(board_member_params)
      render json: board_member, status: 200
    else
      render json:
      { errors: {
          user_id: "user_id can't be blank and must be a number",
        card_id: "board_id can't be blank and must be a number"}
        }, status: 422
    end
  end

  def destroy
    board_member = BoardMember.where(id: params[:id]).first
    if board_member
      board_member.destroy
      render json: { success: "card assignment destroyed"}, status: 200
    else
      render json:
      { errors: {
        id: "card assignment #{params[:id]} not found, failed to destroy"}
        }, status: 422
    end
  end

  private
  def board_member_params
    params.require(:board_member).permit(:board_id, :user_id)
  end
end
