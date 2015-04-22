class BoardsController < ApplicationController
  def index
    @user = User.find_by(id: params[:user_id])
    @boards = @user.boards
  end

  def show
    @user = User.find_by(id: params[:user_id])
    @board = Board.find_by(id: params[:id])
    @lists = @board.lists
  end
end
