require 'rails_helper'

RSpec.describe ListsController, type: :controller do
  before(:each) do
    @user = User.create(name: "Doc Holliday",
                        email: "doc@holliday.com",
                        password: "password",
                        password_confirmation: "password")
    session[:user_id] = @user.id
    @board = Board.create(name: "Software Developer Job Hunt", user_id: @user.id)
    @list = @board.lists.first
  end

  describe "POST #create" do
    context "when is successfully created" do
      before(:each) do
        @valid_attributes = { name: "Applied", board_id: @board.id, position_id: 10 }
        post(:create, list: @valid_attributes)
      end

      it { is_expected.to respond_with 201 }

      it "changes the list count by 1" do
        expect{
          post(:create, list: @valid_attributes)
        }.to change{List.count}.by(1)
      end

      it "renders the JSON representation for the created list" do
        body = response.body
        created_list = List.last.to_json
        expect(body).to eql created_list
      end
    end

    context "when fails to create" do
      before(:each) do
        @invalid_attributes = { name: nil, board_id: @list.id, position_id: nil }
        post(:create, list: @invalid_attributes)
      end

      it { is_expected.to respond_with 422 }

      it "renders an errors json" do
        list_json = JSON.parse(response.body, symbolize_names: true)
        expect(list_json).to have_key(:errors)
      end

      it "renders the json errors on why the list could not be created" do
        list_json = JSON.parse(response.body, symbolize_names: true)
        expect(list_json[:errors][:name]).to include "can't be blank"
        expect(list_json[:errors][:position_id]).to include "must be a number"
        expect(list_json[:errors][:board_id]).to include "must be a number"
      end
    end
  end


  describe "PUT #update" do
    context "when is successfully updated" do
      before(:each) do
        @valid_attributes = { name: "Interview", board_id: @board.id }
        put(:update, { id: @list.id, list: @valid_attributes })
      end

      it { is_expected.to respond_with 200 }

      it "renders a JSON of the updated list" do
        body = response.body
        updated_list = List.where(id: @list.id).first.to_json
        expect(body).to eql updated_list
      end
    end

    context "when fails to update" do
      before(:each) do
        @invalid_attributes = { name: nil, board_id: @board.id, position_id: nil }
        put(:update, id: @list.id, list: @invalid_attributes)
      end

      it { is_expected.to respond_with 422 }

      it "renders an errors json" do
        list_json = JSON.parse(response.body, symbolize_names: true)
        expect(list_json).to have_key(:errors)
      end

      it "renders the json errors on why the list could not be created" do
        list_json = JSON.parse(response.body, symbolize_names: true)
        expect(list_json[:errors][:name]).to include "can't be blank"
        expect(list_json[:errors][:position_id]).to include "must be a number"
        expect(list_json[:errors][:board_id]).to include "must be a number"
      end
    end
  end

  describe "DELETE #destroy" do

    context "when is successfully destroyed" do
      before(:each) do
        @new_list = List.create(board_id: @board.id, name: "Interested In", position_id: 10)
      end

      it "has a success 200 status code" do
        delete :destroy, id: @new_list.id
        expect(response).to have_http_status(200)
      end

      it "changes the list count by -1" do
        expect{
          delete :destroy, id: @new_list.id
        }.to change{ List.count }.by(-1)
      end

      it "renders a json success" do
        delete :destroy, id: @new_list.id
        success_response = JSON.parse(response.body, symbolize_names: true)
        expect(success_response).to have_key(:success)
      end
    end

    context "when fails to find list to destroy" do
      before(:each) do
        delete :destroy, id: "foo"
      end

      it "responds with a 422 status" do
        expect(response).to have_http_status(422)
      end

      it "does not change the list count" do
        expect{
          delete :destroy, id: "fail"
        }.to change{ List.count }.by(0)
      end

      it "renders an errors json" do
        success_response = JSON.parse(response.body, symbolize_names: true)
        expect(success_response).to have_key(:errors)
      end

      it "renders the json errors on why the list could not be destroyed" do
        fail_response = JSON.parse(response.body, symbolize_names: true)
        expect(fail_response[:errors][:id]).to include "not found"
      end
    end
  end

end
