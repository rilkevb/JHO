class BoardsController < ApplicationController
  include SessionsHelper

  before_action :redirect_unless_logged_in

  def index
    @board = Board.new
    @boards = Board.where(user_id: session[:user_id])
  end

  def show
    @board = Board.where(id: params[:id]).first
    render json: @board
  end

  def create
    @board = Board.new(board_params)
    user = User.find_by(id: session[:user_id])
    @board.user_id = user.id
    if @board.save
      user.boards << @board
      render json: @board, status: 201
    else
      render json: {errors: { name: "Board name can't be blank"} }, status: 422
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
    @board = Board.find(params[:id])
    if @board.destroy!
      render json: { success: "board destroyed!"}
    else
      render json: { error: "board failed to destroy"}
    end
  end

  private
  def board_params
    params.require(:board).permit(:name)
  end
end
