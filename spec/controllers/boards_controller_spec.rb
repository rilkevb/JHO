require "rails_helper"

RSpec.describe BoardsController, :type => :controller do
  before(:each) {
    @user = User.create(name: "Doc Holliday",
                           email: "doc@holliday.com",
                           password: "password",
                           password_confirmation: "password")
    session[:user_id] = @user.id
    @boards = @user.boards
    @board_1 = Board.create(name: "Software Developer Job Hunt", user_id: @user.id)
    @request_headers = {
        "Accept" => "application/json",
        "Content-Type" => "application/json"
      }
  }

  after(:each) {
    session.delete(:user_id)
    @user.destroy
    @board_1.destroy
  }
  # let(:new_board) { Board.new }
  # let(:board_1) { Board.create(name: "Software Developer Job Hunt", user_id: user.id) }
  # let(:boards) { user.boards }
  # let(:request_headers) { request_headers = {
  #       "Accept" => "application/json",
  #       "Content-Type" => "application/json"
  #     } }

  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    # xit "loads a new board for creation" do
    #   get :index
    #   # object #s don't match
    #   expect(assigns(:board)).to eq(Board.new)
    # end

    it "loads all of the user's boards" do
      get :index
      expect(assigns(:boards)).to match_array(@boards)
    end
  end

  describe "GET #show" do
    it "responds successfully with an HTTP 200 status code" do
      # The get method takes three arguments: a path, a set of HTTP parameters, and any additional headers to be included in the request.
      get :show, { id: @board_1.id }, @request_headers
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "finds and loads the given board" do
      get :show, { id: @board_1.id }, @request_headers
      expect(assigns(:board)).to match(@board_1)
    end

    it "responds with a JSON of the board" do
      get :show, { id: @board_1.id }, @request_headers
      body = response.body
      json_board = @board_1.to_json
      expect(body).to match(json_board)
    end
  end

describe "POST #create" do
    context "when is successfully created" do
      before(:each) do
        @board_attributes = { name: "Software Engineer" }
        post :create, board: @board_attributes
      end

      it { should respond_with 201 }

      it "renders the json representation for the board record just created" do
        board_response = JSON.parse(response.body, symbolize_names: true)
        expect(board_response[:name]).to eql @board_attributes[:name]
      end
    end

    context "when is not created" do
      before(:each) do
        @invalid_board_attributes = { name: nil }
        post :create, { board: @invalid_board_attributes }
      end

      it { should respond_with 422 }

      it "renders an errors json" do
        board_response = JSON.parse(response.body, symbolize_names: true)
        expect(board_response).to have_key(:errors)
      end

      it "renders the json errors on why the board could not be created" do
        board_response = JSON.parse(response.body, symbolize_names: true)
        expect(board_response[:errors][:name]).to include "can't be blank"
      end
    end
  end
end
