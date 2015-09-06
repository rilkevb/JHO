class BoardsController < ApplicationController

  def index
    @board = Board.new
    @user = User.where(auth_token: request.env["HTTP_AUTH_TOKEN"]).first
    @boards = Board.where(user_id: @user.id)
    render json: @boards, status: 200
  end

  def show
    @board = Board.where(id: params[:id]).first
    render json: @board
  end

  def create
    @board = Board.new(board_params)
    @user = User.where(auth_token: request.env["HTTP_AUTH_TOKEN"]).first
    @board.user_id = @user.id
    if @board.save
      render json: @board, status: 201
    else
      render json: {errors: { user_id: "user_id not found, failed to create board", name: "Board name can't be blank or have fewer than 3 characters"} }, status: 422
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
    params.require(:board).permit(:name, :user_id)
  end
end
