require 'rails_helper'

RSpec.describe BoardMembersController, type: :controller do
  before(:each) do
    @user = User.create(name: "Doc Holliday",
                        email: "doc@holliday.com",
                        password: "password",
                        password_confirmation: "password")
    session[:user_id] = @user.id
    @boards = @user.boards
    @board = Board.create(name: "Software Developer Job Hunt", user_id: @user.id)
    @board_member_1 = BoardMember.create(board_id: @board.id, user_id: @user.id, admin: true)

    request.headers['Accept'] = "application/json"
    request.headers['Content-Type'] = "application/json"
    request.headers['name'] = "#{@user.name}"
    request.headers['auth_token'] = "#{@user.auth_token}"
  end

  describe "POST #create" do
    context "when is successfully created" do
      before(:each) do
        @valid_attributes = { board_id: @board.id, user_id: @user.id }
        post(:create, board_member: @valid_attributes)
      end

      it { is_expected.to respond_with 201 }

      it "changes board member count by 1" do
        expect{
          post(:create, board_member: @valid_attributes)
        }.to change{ BoardMember.count}.by(1)
      end

      it "renders a JSON of the created CardAssignment" do
        body = response.body
        bm_json = BoardMember.last.to_json
        expect(body).to eql bm_json
      end
    end

    context "when fails to create" do
      before(:each) do
        @invalid_attributes = { board_id: "foo", user_id: nil }
        post(:create, board_member: @invalid_attributes)
      end

      it { is_expected.to respond_with 422 }

      it "renders an errors JSON" do
        body = JSON.parse(response.body, symbolize_names: true)
        expect(body).to have_key(:errors)
      end

      it "renders the json errors on why the board member could not be created" do
        bm_json = JSON.parse(response.body, symbolize_names: true)
        expect(bm_json[:errors][:board_id]).to include "can't be blank"
        expect(bm_json[:errors][:user_id]).to include "can't be blank"
      end
    end

    describe "PUT #update" do
      context "when is successfully updated" do
        before(:each) do
          @board_member = BoardMember.create(board_id: @board.id, user_id: @user.id, admin: true)
          @valid_attributes = { board_id: 2, user_id: 2 }
          put(:update, {id: @board_member.id, board_member: @valid_attributes})
        end

        it { is_expected.to respond_with 200 }

        it "changes board_member count by 0" do
          expect {
            put(:update, {id: @board_member.id, board_member: @valid_attributes})
          }.to change{ BoardMember.count}.by(0)
        end

        it "renders a JSON of the created CardAssignment" do
          body = response.body
          bm_json = BoardMember.last.to_json
          expect(body).to eql bm_json
        end
      end

      context "when fails to update" do
        before(:each) do
          @board_member = BoardMember.create(board_id: @board.id, user_id: @user.id)
          @valid_attributes = { board_id: "bar", user_id: "baz" }
          put(:update, {id: @board_member.id, board_member: @valid_attributes})
        end

        it { is_expected.to respond_with 422 }

        it "renders an errors JSON" do
          body = JSON.parse(response.body, symbolize_names: true)
          expect(body).to have_key(:errors)
        end

        it "renders the json errors on why the card assignment could not be created" do
          bm_json = JSON.parse(response.body, symbolize_names: true)
          expect(bm_json[:errors][:board_id]).to include "can't be blank"
          expect(bm_json[:errors][:user_id]).to include "can't be blank"
        end
      end

      describe "DELETE #destroy" do
        context "when is successfully destroyed" do
          before(:each) do
            @board_member = BoardMember.create(board_id: @board.id, user_id: @user.id)
            delete(:destroy, id: @board_member.id)
          end

          it "renders a success JSON" do
            body = JSON.parse(response.body, symbolize_names: true)
            expect(body).to have_key(:success)
          end

          # it "changes Card Assignment count by -1" do
          #   expect{

          #   }.to change{ BoardMember.count}.by(-1)
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
          bm_json = JSON.parse(response.body, symbolize_names: true)
          expect(bm_json[:errors][:id]).to include "not found"
        end
      end
    end
  end
end
