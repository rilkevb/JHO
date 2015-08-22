require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  before(:each) do
    @user = User.create(name: "The Doctor", email: "doctor@thetardis.com", password: "Fantastic!",password_confirmation: "Fantastic!")
    @board= Board.create(name: "Web Dev", user_id: @user.id)
    @list = List.create(board_id: @board.id, position_id: 1, name: "Interested In")
    @card = Card.create(organization_name: "Google", list_id: @list.id)
    @tasks = @card.tasks
  end

  describe "GET #index" do
    it "loads all of a card's tasks" do
      get :index, card_id: @card.id
      expect(assigns(:tasks)).to match_array(@tasks)
    end
  end

  describe "POST #create" do
    before(:each) do
      post :create, card_id: @card, task: { title: "Some task", card_id: @card.id }
    end
    context "when is successfully created" do
      it "returns a success 200 code" do
        expect(response).to have_http_status 200
      end

      it "increments the task count" do
        expect{
          post :create, card_id: @card, task: { title: "New task", card_id: @card.id }
        }.to change{Task.count}.by(1)
      end

      it "responds with a JSON of the task" do

        body = response.body
        json_task = @task.to_json
        expect(body).to match(json_task)
      end
    end
    context "when is not created" do
    end
  end
end
