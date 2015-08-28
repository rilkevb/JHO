require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe "POST #create" do
    context "when is successfully created" do
      before(:each) do
        @user = User.create(name: "Jigglypuff", email: "sing@song.com", password: "thebestyoueverhad", password_confirmation: "thebestyoueverhad")

        request.headers['Accept'] = "application/json"
        request.headers['Content-Type'] = "application/json"
        request.headers['name'] = "#{@user.name}"
        request.headers['auth_token'] = "#{@user.auth_token}"

        post :create, session: { email: "sing@song.com" , password: "thebestyoueverhad" }
      end

      it "should have a 201 status" do
        expect(response).to have_http_status 201
      end

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
end
