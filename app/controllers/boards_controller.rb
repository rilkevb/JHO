class BoardsController < ApplicationController
  # @current_user is set in ApplicationController#authenticate

  def index
    # board = @current_user.boards.first
    # render json: board, status: 200
    redirect :show
  end

  def dashboard
    board = @current_user.boards.first # Board object
    lists = board.lists # ActiveRecord collection of List objects
    cards = lists.map { |list| list.cards } # AR collection of AR collections of cards
    flat_cards = cards.flatten! # single AR collection of all cards
    tasks = flat_cards.map { |card| card.tasks } # AR collection of AR collection of tasks

    # create a hash of the board's attributes
    board_hash = board.attributes
    board_hash["lists"] = []

    # build out nested board hash by adding lists and cards
    lists.each_with_index do |list, index|
      board_hash["lists"] << list.attributes
      board_hash["lists"][index]["cards"] = list.cards
      cards.each_with_index do |card, i|
        ap card
        ap i
        board_hash["lists"][index]["cards"][i]["tasks"] = []
        board_hash["lists"][index]["cards"][i]["tasks"] << card.tasks
      end
    end

    # { # board
    #   lists: [ #board["lists"]
    #     { name: "Something", # boards["lists"][0]
    #       cards: [ # boards["lists"][0]["cards"]
    #         { name: "Card", # boards["lists"][0]["cards"][0]
    #           tasks: [ # boards["lists"][0]["cards"][0]["tasks"]
    #             { title: "do it now"}, # boards["lists"][0]["cards"][0]["tasks"][0]
    #             { title: "do it again"}
    #           ]
    #           }
    #       ]
    #       },
    #     { name: "Other",
    #       cards: [
    #         { name: "New Card",
    #           tasks: [
    #             { title: "Say what"},
    #             { title: "Say what again"}
    #           ]
    #           }
    #       ]
    #       }
    #   ]
    # }

    # refactoring for efficiency
    # board.lists.include(:cards).to_json

    # definitely should refactor this to use ActiveModel::Serializer
    render json: { board: board_hash, lists: lists, cards: cards.flatten!, tasks: tasks.flatten! }
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
