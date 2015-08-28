require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe "POST #create" do
    context "when is successfully created" do
      before(:each) do
        @user = User.create(name: "Jigglypuff", email: "sing@song.com", password: "thebestyoueverhad", password_confirmation: "thebestyoueverhad")

        @request_headers = {
          "Accept" => "application/json",
          "Content-Type" => "application/json",
          "name" => "#{@user.name}",
          "auth_token" => "#{@user.auth_token}"
        }

        post :create, session: { email: "sing@song.com" , password: "thebestyoueverhad" }, @request_headers
      end

      it "should have a 201 status" do
        expect(response).to have_http_status 201
      end

      it { is_expected.to set_session[:user_id].to @user.id }

      it "renders a success JSON" do
        body = JSON.parse(response.body, symbolize_names: true)
        expect(body).to have_key(:success)
      end
    end

    context "when is not created" do
      before(:each) do
        # same as above but user was never created
        post :create, session: { email: "sing@song.com" , password: "thebestyoueverhad" }
      end

      it "responds with a 401 unauthorized status" do
        expect(response).to have_http_status 401
      end
    end
  end

  describe "DELETE #destroy" do
    context "when is successfully destroyed" do
      before(:each) do
        @user = User.create(name: "Jigglypuff",
                            email: "sing@song.com",
                            password: "thebestyoueverhad",
                            password_confirmation: "thebestyoueverhad")
        post :create, session: { email: "sing@song.com" , password: "thebestyoueverhad" }
        delete :destroy, id: @user.id
      end

      it "sets @current_user to nil" do
        expect(assigns(:current_user)).to be_nil
      end

      it { is_expected.to_not set_session[:user_id] }

      it "expect it to have a 200 status" do
        expect(response).to have_http_status 200
      end
    end
  end
end
