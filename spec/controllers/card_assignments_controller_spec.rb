require 'rails_helper'

RSpec.describe CardAssignmentsController, type: :controller do
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

    request.headers['Accept'] = "application/json"
    request.headers['Content-Type'] = "application/json"
    request.env['HTTP_NAME'] = "#{@user.name}"
    request.env['HTTP_AUTH_TOKEN'] = "#{@user.auth_token}"
  end

  describe "POST #create" do
    context "when is successfully created" do
      before(:each) do
        @valid_attributes = { card_id: @card.id, user_id: @user.id }
        post(:create, card_assignment: @valid_attributes)
      end

      it { is_expected.to respond_with 201 }

      it "changes Card Assignment count by 1" do
        expect{
          post(:create, card_assignment: @valid_attributes)
        }.to change{ CardAssignment.count}.by(1)
      end

      it "renders a JSON of the created CardAssignment" do
        body = response.body
        ca_json = CardAssignment.last.to_json
        expect(body).to eql ca_json
      end
    end

    context "when fails to create" do
      before(:each) do
        @invalid_attributes = { card_id: "foo", user_id: nil }
        post(:create, card_assignment: @invalid_attributes)
      end

      it { is_expected.to respond_with 422 }

      it "renders an errors JSON" do
        body = JSON.parse(response.body, symbolize_names: true)
        expect(body).to have_key(:errors)
      end

      it "renders the json errors on why the card assignment could not be created" do
        ca_json = JSON.parse(response.body, symbolize_names: true)
        expect(ca_json[:errors][:card_id]).to include "can't be blank"
        expect(ca_json[:errors][:user_id]).to include "can't be blank"
      end
    end

    describe "PUT #update" do
      context "when is successfully updated" do
        before(:each) do
          @card_assignment = CardAssignment.create(card_id: @card.id, user_id: @user.id)
          @valid_attributes = { board_id: 2, user_id: 2 }
          put(:update, {id: @card_assignment.id, card_assignment: @valid_attributes})
        end

        it { is_expected.to respond_with 200 }

        it "changes card_assignment count by 0" do
          expect {
            put(:update, {id: @card_assignment.id, card_assignment: @valid_attributes})
          }.to change{ CardAssignment.count}.by(0)
        end

        it "renders a JSON of the created CardAssignment" do
          body = response.body
          ca_json = CardAssignment.last.to_json
          expect(body).to eql ca_json
        end
      end

      context "when fails to update" do
        before(:each) do
          @card_assignment = CardAssignment.create(card_id: @card.id, user_id: @user.id)
          @valid_attributes = { board_id: "bar", user_id: "baz" }
          put(:update, {id: @card_assignment.id, card_assignment: @valid_attributes})
        end

        it { is_expected.to respond_with 422 }

        it "renders an errors JSON" do
          body = JSON.parse(response.body, symbolize_names: true)
          expect(body).to have_key(:errors)
        end

        it "renders the json errors on why the card assignment could not be created" do
          ca_json = JSON.parse(response.body, symbolize_names: true)
          expect(ca_json[:errors][:card_id]).to include "can't be blank"
          expect(ca_json[:errors][:user_id]).to include "can't be blank"
        end
      end

      describe "DELETE #destroy" do
        context "when is successfully destroyed" do
          before(:each) do
            @card_assignment = CardAssignment.create(card_id: @card.id, user_id: @user.id)
            delete(:destroy, id: @card_assignment.id)
          end

          it "renders a success JSON" do
            body = JSON.parse(response.body, symbolize_names: true)
            expect(body).to have_key(:success)
          end

          # it "changes Card Assignment count by -1" do
          #   expect{

          #   }.to change{ CardAssignment.count}.by(-1)
        end
      end

      context "when fails to destroy" do
        before(:each) do
          delete(:destroy, id: "foo")
        end

        it "renders an errors JSON" do
          body = JSON.parse(response.body, symbolize_names: true)
          expect(body).to have_key(:errors)
        end

        it "renders the json errors on why the card assignment could not be destroyed" do
          ca_json = JSON.parse(response.body, symbolize_names: true)
          expect(ca_json[:errors][:id]).to include "not found"
        end
      end
    end
  end
end
