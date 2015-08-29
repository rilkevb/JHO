class BoardsController < ApplicationController

  def index
    @board = Board.new
    @boards = Board.where(user_id: session[:user_id])
    render json: @boards, status: 200
  end

  def show
    @board = Board.where(id: params[:id]).first
    render json: @board
  end

  def create
    @board = Board.new(board_params)
    user = User.find_by(email: request.headers["email"])
    @board.user_id = user.id
    if @board.save
      user.boards << @board
      render json: @board, status: 201
    else
      render json: {errors: { name: "Board name can't be blank or have fewer than 3 characters"} }, status: 422
    end
  end

  def update
    board = Board.where(id: params[:id]).first
    if board.update(board_params)
      render json: board, status: 200
    else
      render json: { errors: { id: "board #{params[:id]} not found, failed to update", name: "board name can't be blank or must contain 3 or more characters" }
                     }, status: 422
    end
  end

  def destroy
    @board = Board.where(id: params[:id]).first
    if @board
      @board.destroy!
      render json: { success: "board destroyed!"}, status: 200
    else
      render json: { errors: { id: "board #{params[:id]} not found, board failed to destroy"} }, status: 422
    end
  end

  private
  def board_params
    params.require(:board).permit(:name)
  end
end
