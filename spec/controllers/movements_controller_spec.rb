require 'rails_helper'

# Action, params, session, flash
# get(:view, {'id' => '12'}, nil, {'message' => 'booya!'})

RSpec.describe MovementsController, type: :controller do
  before(:each) do
    @user = User.create(name: "The Doctor", email: "doctor@thetardis.com", password: "Fantastic!",password_confirmation: "Fantastic!")
    @board= Board.create(name: "Web Dev", user_id: @user.id)
    @list = List.create(board_id: @board.id, position_id: 1, name: "Interested In")
    @card = Card.create(organization_name: "Google", list_id: @list.id)
    @movements = @card.movements
    @original_movement = Movement.create(current_list: "Find Advocate", card_id: @card.id)

    request.headers['Accept'] = "application/json"
    request.headers['Content-Type'] = "application/json"
    request.headers['name'] = "#{@user.name}"
    request.headers['auth_token'] = "#{@user.auth_token}"
  end

  describe "POST #create" do

    context "when is successfully created" do
      before(:each) do
        @valid_movement_attrs = { current_list: "Negotiation", card_id: @card.id }
        post(:create, @valid_movement_attrs)
      end

      it "responds with a success 200 code" do
        expect(response).to have_http_status 200
      end

      it "increments the movement count by 1" do
        expect{
          post(:create, @valid_movement_attrs)
        }.to change{Movement.count}.by(1)
      end

      it "renders a JSON of the created movement" do
        body = response.body
        json_movement = Movement.last.to_json
        expect(body).to eql(json_movement)
      end

      it "renders the movement json current list" do
        movement_json = JSON.parse(response.body, symbolize_names: true)
        expect(movement_json[:current_list]).to eql @valid_movement_attrs[:current_list]
      end
    end

    context "when is not created" do
      before(:each) do
        @invalid_movement_attrs =  { current_list: "no", card_id: @card.id }
        post(:create, @invalid_movement_attrs)
      end

      it { is_expected.to respond_with 422 }

      it "increments the movement count by 0" do
        expect{
          post(:create, @invalid_movement_attrs)
        }.to change{Movement.count}.by(0)
      end

      it "renders an errors json" do
        movement_json = JSON.parse(response.body, symbolize_names: true)
        expect(movement_json).to have_key(:errors)
      end

      it "renders the json errors on why the movement could not be created" do
        movement_json = JSON.parse(response.body, symbolize_names: true)
        expect(movement_json[:errors][:current_list]).to include "can't be blank"
      end
    end
  end

  describe "PUT #update" do

    context "when is successfully updated" do
      before(:each) do
        @valid_attributes = { card_id: @card.id, id: @original_movement.id, current_list: "Outcome" }
        put(:update, @valid_attributes)
      end

      it "responds with a success 200 code" do
        expect(response).to have_http_status 200
      end

      it "updates the current list" do
        movement_response = JSON.parse(response.body, symbolize_names: true)
        expect(movement_response[:current_list]).to eql(@valid_attributes[:current_list])
      end

      it "does not change the movement count" do
        expect{
          put(:update, @valid_attributes)
        }.to change{Movement.count}.by(0)
      end

      it "renders a JSON of the updated movement" do
        body = response.body
        json_movement = Movement.where(id: @valid_attributes[:id]).first.to_json
        expect(body).to eql(json_movement)
      end
    end

    context "when is not updated" do
      before(:each) do
        @invalid_attributes = { card_id: @card.id, id: @original_movement.id, current_list: "" }
        put(:update, @invalid_attributes)
      end

      it { is_expected.to respond_with 422 }

      it "renders an errors json" do
        movement_json = JSON.parse(response.body, symbolize_names: true)
        expect(movement_json).to have_key(:errors)
      end

      it "renders the json errors on why the movement could not be created" do
        movement_json = JSON.parse(response.body, symbolize_names: true)
        expect(movement_json[:errors][:current_list]).to include "can't be blank"
      end
    end
  end

  describe "DELETE #destroy" do
    context "when is successfully destroyed" do
      before(:each) do
        @movement = Movement.create(current_list: "Cool movement", card_id: @card.id)
      end

      it "changes the movement count by -1" do
        expect{
          delete :destroy, card_id: @card.id, id: @movement.id
        }.to change{Movement.count}.by(-1)
      end

      it "has a success 200 status code" do
        delete :destroy, card_id: @card, id: @movement
        expect(response).to have_http_status(200)
      end

      it "renders a json success" do
        delete :destroy, card_id: @card, id: @movement
        success_response = JSON.parse(response.body, symbolize_names: true)
        expect(success_response).to have_key(:success)
      end
    end

    context "when it fails to find a movement to destroy" do
      it "renders an errors json" do
        delete :destroy, card_id: @card, id: "fail"
        success_response = JSON.parse(response.body, symbolize_names: true)
        expect(success_response).to have_key(:errors)
      end

      it "renders the json errors on why the movement could not be destroyed" do
        delete :destroy, card_id: @card, id: "foo"
        destroy_response = JSON.parse(response.body, symbolize_names: true)
        expect(destroy_response[:errors][:id]).to include "not found"
      end
    end
  end
end
