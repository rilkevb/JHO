require "rails_helper"

RSpec.describe CardsController, :type => :controller do

  before(:each) do
    @user = User.create(name: "Doc Holliday",
                        email: "doc@holliday.com",
                        password: "password",
                        password_confirmation: "password")
    session[:user_id] = @user.id
    @boards = @user.boards
    @board_1 = Board.create(name: "Software Developer Job Hunt", user_id: @user.id)
    @list = @board_1.lists.first
    @card = Card.create(list_id: @list.id, organization_name: "Dev Bootcamp")
  end

  describe "POST #create" do
    context "when is successfully created" do
      before(:each) do
        @valid_attributes = { organization_name: "Dropbox", list_id: @list.id }
        post(:create, card: @valid_attributes)
      end

      it { is_expected.to respond_with 201 }

      it "changes the card count by 1" do
        expect{
          post(:create, card: @valid_attributes)
        }.to change{Card.count}.by(1)
      end

      it "renders the JSON representation for the created card record" do
        body = response.body
        created_card = Card.last.to_json
        expect(body).to eql created_card
      end
    end

    context "when fails to create" do
      before(:each) do
        @invalid_attributes = { organization_name: nil, list_id: @list.id }
        post(:create, card: @invalid_attributes)
      end

      it { is_expected.to respond_with 422 }

      it "renders an errors json" do
        card_json = JSON.parse(response.body, symbolize_names: true)
        expect(card_json).to have_key(:errors)
      end

      it "renders the json errors on why the card could not be created" do
        card_json = JSON.parse(response.body, symbolize_names: true)
        expect(card_json[:errors][:organization_name]).to include "can't be blank"
      end
    end
  end


  describe "PUT #update" do
    context "when is successfully updated" do
      before(:each) do
        @valid_attributes = { id: @card.id, organization_name: "Google", list_id: @list.id }
        put(:update, card: @valid_attributes)
      end

      it { is_expected.to respond_with 200 }

      it "renders a JSON of the updated card" do
        body = JSON.parse(response.body)
        updated_card = Card.where(id: @valid_attributes.id).first.to_json
        expect(body).to eql updated_card
      end
    end

    context "when fails to update" do
      before(:each) do
        @invalid_attributes = { id: @card.id, organization_name: nil, list_id: @list.id }
        put(:update, card: @invalid_attributes)
      end

      it { is_expected.to respond_with 422 }

      it "renders an errors json" do
        card_json = JSON.parse(response.body, symbolize_names: true)
        expect(card_json).to have_key(:errors)
      end

      it "renders the json errors on why the card could not be created" do
        card_json = JSON.parse(response.body, symbolize_names: true)
        expect(card_json[:errors][:organization_name]).to include "can't be blank"
      end
    end
  end

  describe "DELETE #destroy" do

    context "when is successfully destroyed" do
      before(:each) do
        @new_card = Card.create(list_id: @list.id, organization_name: "Salesforce")
      end

      it "has a success 200 status code" do
        delete :destroy, id: @new_card
        expect(response).to have_http_status(200)
      end

      it "changes the card count by -1" do
        expect{
          delete :destroy, id: @new_card.id
        }.change{Card.count}.by(-1)
      end

      it "renders a json success" do
        delete :destroy, id: @new_card.id
        success_response = JSON.parse(response.body, symbolize_names: true)
        expect(success_response).to have_key(:success)
      end
    end

    context "when fails to find card to destroy" do

      it "responds with a 422 status" do
        expect(response).to have_http_status(422)
      end

      it "does not change the card count" do
        expect{
          delete :destroy, id: "fail"
        }.to_not change{Card.count}.by(0)
      end

      it "renders an errors json" do
        delete :destroy, id: "fail"
        success_response = JSON.parse(response.body, symbolize_names: true)
        expect(success_response).to have_key(:errors)
      end

      it "renders the json errors on why the movement could not be destroyed" do
        delete :destroy, id: "foo"
        fail_response = JSON.parse(response.body, symbolize_names: true)
        expect(fail_response[:errors][:id]).to include "not found"
      end
    end
  end
end
