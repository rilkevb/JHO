require "rails_helper"

RSpec.describe BoardsController, :type => :controller do
  before(:each) do
    @user = User.create(name: "Doc Holliday",
                        email: "doc@holliday.com",
                        password: "password",
                        password_confirmation: "password")
    @board_1 = Board.create(name: "Software Developer Job Hunt", user_id: @user.id)
    @board_2 = Board.create(name: "Project Manager Job Hunt", user_id: @user.id)
    @boards = @user.boards

    request.headers['Accept'] = "application/json"
    request.headers['Content-Type'] = "application/json"
    request.headers['name'] = "#{@user.name}"
    request.headers['auth_token'] = "#{@user.auth_token}"
  end

  # after(:each) do
  #   @user.destroy
  #   @board_1.destroy
  #   @board_2.destroy
  # end

  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "loads all of the user's boards" do
      get :index
      expect(assigns(:boards)).to match_array(@boards)
    end

    it "renders the user's boards as a JSON" do
      get :index
      body = response.body
      boards = @boards.to_json
      expect(body).to eql(boards)
    end
  end

  describe "GET #show" do
    it "responds successfully with an HTTP 200 status code" do
      # The get method takes three arguments: a path, a set of HTTP parameters, and any additional headers to be included in the request.
      get :show, { id: @board_1.id }
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "finds and loads the given board" do
      get :show, { id: @board_1.id }
      expect(assigns(:board)).to match(@board_1)
    end

    it "responds with a JSON of the board" do
      get :show, { id: @board_1.id }
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
        expect(board_response[:errors][:user_id]).to include "not found"
        expect(board_response[:errors][:name]).to include "can't be blank"
      end
    end
  end

  describe "PUT #update" do

    context "when is successfully updated" do
      before(:each) do
        @board_attributes = { name: "Software Engineer" }
        put(:update, { id: @board_1.id, board: @board_attributes})
      end

      it { should respond_with 200 }

      it "renders the json representation for the updated board record" do
        board_response = JSON.parse(response.body, symbolize_names: true)
        expect(board_response[:name]).to eql @board_attributes[:name]
      end
    end

    context "when is not updated" do
      before(:each) do
        @invalid_board_attributes = { name: nil }
        put :update, {id: @board_1.id, board: @invalid_board_attributes }
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

  describe "delete #destroy" do
    context "when is successfully destroyed" do
      before(:each) do
        @board = Board.create(name: "Full Stack Unicorn", user_id: @user.id)
      end

      it "changes the board count by -1" do
        @new_board = Board.create(name: "UX Expert", user_id: @user.id)
        expect{
          delete :destroy, user_id: @user.id, id: @new_board.id
        }.to change{Board.count}.by(-1)
      end

      it "has a success 200 status code" do
        delete :destroy, user_id: @user, id: @board
        expect(response).to have_http_status(200)
      end

      it "renders a json success" do
        delete :destroy, user_id: @user, id: @board
        success_response = JSON.parse(response.body, symbolize_names: true)
        expect(success_response).to have_key(:success)
      end
    end

    context "when it fails to find a board to destroy" do
      it "renders an errors json" do
        delete :destroy, user_id: @user, id: "fail"
        success_response = JSON.parse(response.body, symbolize_names: true)
        expect(success_response).to have_key(:errors)
      end

      it "renders the json errors on why the board could not be destroyed" do
        delete :destroy, user_id: @user, id: "foo"
        destroy_response = JSON.parse(response.body, symbolize_names: true)
        expect(destroy_response[:errors][:id]).to include "not found"
      end
    end
  end
end
