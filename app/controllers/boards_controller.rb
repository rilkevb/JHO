class BoardsController < ApplicationController
  def index
    @user = User.find_by(id: params[:user_id])
    @boards = @user.boards
  end

  def show
    @user = User.find_by(id: params[:user_id])
    @board = Board.find_by(id: params[:id])
  end

  def create
    user = User.find_by(id: params[:id])
    board = user.boards.create(name: params[:name])
    if board.save
      generate_board_lists(board)
    else
      render json: {error: "board failed to save"}
    end
  end
end
