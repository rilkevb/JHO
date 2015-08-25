require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #new" do
    @user = User.new
    it "loads a blank user for the new user form" do
      expect(assigns(:user)).to eq(@user)
    end
  end

  describe "POST #create" do

    context "when is successfully created" do
      before(:each) do
        @valid_attributes = { name: "Jon Snow", email: "north@thewall.com", password: "knowNothing", password_confirmation: "knowNothing" }
        post :create, user: @valid_attributes
      end

      it "should add to the user count" do
        expect{
          user = User.create(name: "The Doctor", email: "doctor@thetardis.com", password: "Fantastic!", password_confirmation: "Fantastic!")
        }.to change{User.count}.by(1)
      end
      # do we need to check first response since it ends with a redirect?
      # it { should respond_with 201 }
      it { should respond_with 302 }
      it "redirects to boards index" do
        expect(response).to redirect_to boards_path
      end
    end

    context "when is not created" do
      before(:each) do
        @invalid_attributes = { name: "foo", email: "bar", password: "baz", password_confirmation: "baz" }
        post :create, { user: @invalid_attributes }
      end

      it { should respond_with 422 }

      it "re-renders the new template" do
        expect(response).to render_template(:new)
      end
    end
  end

  describe "PUT #update" do
    context "when is successfully updated" do
      before(:each) do
        @user = User.create({ name: "Lana Kane", email: "Lana@isis.com", password: "dangerZone", password_confirmation: "dangerZone" })
        put :update, id: @user, user: { name: "Sterling Mallory Archer", email: "sterling@isis.com", password: "burtReynolds", password_confirmation: "burtReynolds"}
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
        put :update, id: @user.id, user: @invalid_attributes
      end

      it { is_expected.to respond_with 422 }

      it "renders an errors json" do
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response).to have_key(:errors)
      end

      it "renders the json errors on why the user could not be created" do
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response[:errors][:name]).to include "can't be blank"
      end
    end
  end

  describe "DELETE #destroy" do
    context "when is successfully destroyed" do
      before(:each) do
        @user = User.create(name: "Agent J", email: "Jay@MIB.com", password: "NoisyCricket", password_confirmation: "NoisyCricket")
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
