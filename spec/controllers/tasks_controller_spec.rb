require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  before(:each) do
    @user = User.create(name: "The Doctor", email: "doctor@thetardis.com", password: "Fantastic!",password_confirmation: "Fantastic!")
    @board= Board.create(name: "Web Dev", user_id: @user.id)
    @list = List.create(board_id: @board.id, position_id: 1, name: "Interested In")
    @card = Card.create(organization_name: "Google", list_id: @list.id)
    @tasks = @card.tasks
    @original_task = Task.create(title: "Sample task", card_id: @card.id)

    token = AuthToken.issue_token({ user_id: @user.id })
    request.headers['Authorization'] = token
  end

  describe "GET #index" do
    before(:each) do
      get :index, card_id: @card.id
    end

    it "loads all of a card's tasks" do
      expect(assigns(:tasks)).to match_array(@tasks)
    end

    it { is_expected.to respond_with 200 }

    it "renders a JSON with of all of the card's the tasks" do
      body = response.body
      tasks = @tasks.to_json
      expect(body).to eql(tasks)
    end
  end

  describe "POST #create" do

    context "when is successfully created" do
      before(:each) do
        @valid_attributes = { title: "Some task", card_id: @card.id }
        post(:create, card_id: @card.id, task: @valid_attributes)
      end

      it "responds with a success 200 code" do
        expect(response).to have_http_status 200
      end

      it "increments the task count by 1" do
        expect{
          post :create, card_id: @card.id, task: @valid_attributes
        }.to change{Task.count}.by(1)
      end

      it "renders a JSON of the created task" do
        body = response.body
        json_task = Task.last.to_json
        expect(body).to eql(json_task)
      end

      it "renders the task json title" do
        task_json = JSON.parse(response.body, symbolize_names: true)
        expect(task_json[:title]).to eql @valid_attributes[:title]
      end
    end

    context "when is not created" do
      before(:each) do
        @invalid_attributes = { card_id: @card, title: "No" }
        post(:create, card_id: @card, task: @invalid_attributes)
      end

      it { is_expected.to respond_with 422 }

      it "renders an errors json" do
        task_json = JSON.parse(response.body, symbolize_names: true)
        expect(task_json).to have_key(:errors)
      end

      it "renders the json errors on why the board could not be created" do
        task_json = JSON.parse(response.body, symbolize_names: true)
        expect(task_json[:errors][:title]).to include "can't be blank"
      end
    end
  end

  describe "PUT #update" do

    context "when is successfully updated" do
      before(:each) do
        @valid_attributes = { title: "Nice task", completed: true }
        put(:update, card_id: @card.id, id: @original_task, task: @valid_attributes)
      end

      it "responds with a success 200 code" do
        expect(response).to have_http_status 200
      end

      it "updates the title" do
        task_response = JSON.parse(response.body, symbolize_names: true)
        expect(task_response[:title]).to eql(@valid_attributes[:title])
      end

      it "updates the completed boolean" do
        task_response = JSON.parse(response.body, symbolize_names: true)
        expect(task_response[:completed]).to eql(@valid_attributes[:completed])
      end

      it "does not change the task count" do
        expect{
          put(:update, card_id: @card.id, id: @original_task, task: @valid_attributes)
        }.to change{Task.count}.by(0)
      end

      it "renders a JSON of the updated task" do
        body = response.body
        json_task = Task.where(id: @original_task).first.to_json
        expect(body).to eql(json_task)
      end
    end

    context "when is not updated" do
      before(:each) do
        @invalid_attributes = { title: "No" }
        put(:update, card_id: @card.id, id: @original_task, task: @invalid_attributes)
      end

      it { is_expected.to respond_with 422 }

      it "renders an errors json" do
        task_json = JSON.parse(response.body, symbolize_names: true)
        expect(task_json).to have_key(:errors)
      end

      it "renders the json errors on why the Task could not be updated" do
        task_json = JSON.parse(response.body, symbolize_names: true)
        expect(task_json[:errors][:title]).to include "can't be blank"
      end
    end
  end

  describe "DELETE #destroy" do

    context "when is successfully destroyed" do
      before(:each) do
        @valid_attributes = { title: "Cool task", card_id: @card.id }
        @task = Task.create(@valid_attributes)
        delete(:destroy, { card_id: @card.id, id: @task.id })
      end

      it "changes the task count by -1" do
        @new_task = Task.create({ title: "Test task", card_id: @card.id })
        expect{
          delete :destroy, card_id: @card.id, id: @new_task.id
        }.to change{Task.count}.by(-1)
      end

      it "has a success 200 status code" do
        expect(response).to have_http_status(200)
      end

      it "renders a json success" do
        success_response = JSON.parse(response.body, symbolize_names: true)
        expect(success_response).to have_key(:success)
      end
    end

    context "when it fails to find a task to destroy" do
      before(:each) do
        @invalid_attributes = { title: "Any Task", card_id: @card, id: "fail" }
        delete(:destroy, @invalid_attributes)
      end

      it "renders an errors json" do
        success_response = JSON.parse(response.body, symbolize_names: true)
        expect(success_response).to have_key(:errors)
      end

      it "renders the json errors on why the task could not be destroyed" do
        destroy_response = JSON.parse(response.body, symbolize_names: true)
        expect(destroy_response[:errors][:id]).to include "not found"
      end
    end
  end
end
