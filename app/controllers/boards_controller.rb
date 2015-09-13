class BoardsController < ApplicationController
  # @current_user is set in ApplicationController#authenticate

  def index
    @board = Board.new
    @boards = Board.where(user_id: @current_user.id)
    render json: @boards, status: 200
  end

  def show
    board = Board.where(id: params[:id]).first
    lists = board.lists
    cards = lists.map { |list| list.cards }

    # create a hash of the board's attributes
    board_hash = board.attributes
    board_hash["lists"] = []

    # build out nested board hash by adding lists and cards
    lists.each_with_index do |list, index|
      board_hash["lists"] << list.attributes
      board_hash["lists"][index]['cards'] = list.cards
    end

    # definitely should refactor this to use ActiveModel::Serializer
    render json: { board: board_hash, lists: lists, cards: cards }
  end

  def create
    board = Board.new(board_params)
    board.user_id = @current_user.id
    if board.save
      render json: board, status: 201
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
    board = Board.where(id: params[:id]).first
    if board
      board.destroy!
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
