class BoardsController < ApplicationController
  def index
    @user = User.find_by(id: params[:user_id])
    @boards = @user.boards
  end

  def show
    @user = User.find_by(id: params[:user_id])
    @board = Board.find_by(id: params[:id])
    @lists = @board.lists
    @card = @lists[0].cards.new(organization_name: params[:organization_name])
  end
end
