require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "POST #create" do
    context "when is successfully created" do
      before(:each) do
        @valid_attributes = { name: "Jon Snow", email: "north@thewall.com", password: "knowNothing", password_confirmation: "knowNothing" }
        post :create, user: @valid_attributes
      end

      it "increments the user count by 1" do
        expect{
          user = User.create(name: "The Doctor", email: "doctor@thetardis.com", password: "Fantastic!", password_confirmation: "Fantastic!")
        }.to change{User.count}.by(1)
      end

      it { should respond_with 201 }

      it "renders a JSON of the created user" do
        body = response.body
        user = User.last.to_json
        expect(body).to include user
      end
    end

    context "when is not created" do
      before(:each) do
        @invalid_attributes = { name: "foo", email: "bar", password: "baz", password_confirmation: "baz" }
        post :create, { user: @invalid_attributes }
      end

      it { is_expected.to respond_with 422 }

      it "renders a JSON error for an invalid name" do
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response[:errors][:name]).to include "can't be blank"
      end

      it "renders a JSON error for an invalid email" do
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response[:errors][:email]).to include "valid format"
      end

      it "renders a JSON error for an invalid password" do
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response[:errors][:password]).to include "at least 6 characters"
      end

      it "renders a JSON error for an invalid password confirmation" do
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response[:errors][:password_confirmation]).to include "must match password"
      end
    end
  end

  describe "PUT #update" do
    context "when is successfully updated" do
      before(:each) do
        @user = User.create(name: "Lana Kane",
                            email: "Lana@isis.com",
                            password: "dangerZone",
                            password_confirmation: "dangerZone")

        token = AuthToken.issue_token({ user_id: @user.id })
        request.headers['Authorization'] = token

        @valid_attributes = { name: "Sterling Mallory Archer",
                              email: "sterling@isis.com",
                              password: "burtReynolds",
                              password_confirmation: "burtReynolds" }

        put(:update, id: @user, user: @valid_attributes)
      end

      it { is_expected.to respond_with 200 }

      it "renders a JSON of the updated user" do
        body = response.body
        json_user = User.where(id: @user.id).first.to_json
        expect(body).to eql(json_user)
      end
    end

    context "when is not updated" do
      before(:each) do
        @user = User.create({ name: "Lana Kane", email: "Lana@isis.com", password: "dangerZone", password_confirmation: "dangerZone" })

        @invalid_attributes = { name: nil, email: "foo", password: "bar", password_confirmation: "bar" }

        token = AuthToken.issue_token({ user_id: @user.id })
        request.headers['Authorization'] = token

        put :update, id: @user.id, user: @invalid_attributes
      end

      it { is_expected.to respond_with 422 }

      it "renders an errors json" do
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response).to have_key(:errors)
      end

      it "renders a JSON error for an invalid name" do
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response[:errors][:name]).to include "can't be blank"
      end

      it "renders a JSON error for an invalid email" do
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response[:errors][:email]).to include "valid format"
      end

      it "renders a JSON error for an invalid password" do
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response[:errors][:password]).to include "at least 6 characters"
      end

      it "renders a JSON error for an invalid password confirmation" do
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response[:errors][:password_confirmation]).to include "must match password"
      end
    end
  end

  describe "DELETE #destroy" do
    context "when is successfully destroyed" do
      before(:each) do
        @user = User.create(name: "Agent J", email: "Jay@MIB.com", password: "NoisyCricket", password_confirmation: "NoisyCricket")

        token = AuthToken.issue_token({ user_id: @user.id })
        request.headers['Authorization'] = token
      end

      it "changes the user count by -1" do
        expect{
          delete :destroy, id: @user
        }.to change{User.count}.by(-1)
      end

      it "has a success status code" do
        delete :destroy, id: @user
        expect(response).to have_http_status(:success)
      end

      it "returns a success json success" do
        delete :destroy, id: @user
        success_response = JSON.parse(response.body, symbolize_names: true)
        expect(success_response).to have_key(:success)
      end
    end

    context "when it fails to find a user to destroy" do
      before(:each) do
        @user = User.create(name: "Agent J", email: "Jay@MIB.com", password: "NoisyCricket", password_confirmation: "NoisyCricket")

        token = AuthToken.issue_token({ user_id: @user.id })
        request.headers['Authorization'] = token

        delete :destroy, id: "foo"
      end

      it  { is_expected.to respond_with 422 }

      it "renders a json error" do
        body = response.body
        response = JSON.parse(body, symbolize_names: true)
        expect(response).to have_key(:errors)
      end

      it "explains why the user was not found" do
        destroy_response = JSON.parse(response.body, symbolize_names: true)
        expect(destroy_response[:errors][:id]).to include "not found"
      end


      it "changes the user count by 0" do
        expect{
          delete :destroy, id: "foo"
        }.to change{User.count}.by(0)
      end
    end
  end
end
