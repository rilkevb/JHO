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
        @user_attributes = { name: "Jon Snow", email: "north@thewall.com", password: "knowNothing", password_confirmation: "knowNothing" }
        post :create, user: @user_attributes
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
        @invalid_user_attributes = { name: "foo", email: "bar", password: "baz", password_confirmation: "baz" }
        post :create, { user: @invalid_user_attributes }
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
      it "has a success status code" do
        expect(response).to have_http_status(:success)
      end
      # could be more specific the updates here
    end
    context "when is not updated" do
      # before(:each) do
      #   @user = User.create({ name: "Lana Kane", email: "Lana@isis.com", password: "dangerZone", password_confirmation: "dangerZone" })
      #   put :update, id: @user, user: { name: "Lana Kane", email: "Lana@isis.com", password: "dangerZone", password_confirmation: "dangerZone" }
      # end

      # shouldn't this be 304 for not modified?
      # it { should respond_with 304 }
      # it { should respond_with 200 }

      # it "re-renders the edit template" do
      #   expect(response).to render_template(:edit)
      # end
    end
  end

  describe "DELETE #destroy" do
    context "when is successfully destroyed" do
      before(:each) do
        @user = User.create(name: "Agent J", email: "Jay@MIB.com", password: "NoisyCricket", password_confirmation: "NoisyCricket")
      end
      it "destroys the specified user" do
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
      it "renders a json error" do
        delete :destroy, id: "foo"
        destroy_response = JSON.parse(response.body, symbolize_names: true)
        expect(destroy_response[:errors][:user_id]).to include "not found"
      end
    end
  end
end
