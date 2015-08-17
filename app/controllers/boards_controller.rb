class BoardsController < ApplicationController
  def index
    # @user = User.find_by(id: session[:user_id])
    # @boards = @user.boards
    @boards = Board.where(user_id: session[:user_id])
    render json: @boards
  end

  def show
    # @user = User.find_by(id: params[:user_id])
    # @board = Board.find_by(id: params[:id])
    @board = Board.where(user_id: session[:user_id]).first
    render json: @board
  end

  def create
    user = User.find(session[:user_id])
    board = user.boards.create(board_params)
    if board.save
      render json: board
    else
      render json: {error: "board failed to save"}
    end
  end

  def update
    board = Boards.where(user_id: session[:user_id])
    if board.update(board_params)
      render json: board
    else
      render json: {error: "board failed to update"}
    end
  end

  def destroy
    @board = Board.find(id: params[:id])
    if @board.destroy!
      render json: { success: "board destroyed!"}
    else
      render json: { error: "board failed to destroy"}
    end
  end


  def board_params
    params.require(:board).permit(:user_id, :name)
  end
end
