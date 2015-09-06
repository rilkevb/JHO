require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe "POST #create" do
    context "when is successfully created" do
      before(:each) do
        @user = User.create(name: "Jigglypuff", email: "sing@song.com", password: "thebestyoueverhad", password_confirmation: "thebestyoueverhad")

        request.headers['Accept'] = "application/json"
        request.headers['Content-Type'] = "application/json"
        request.env['HTTP_NAME'] = "#{@user.name}"
        request.env['HTTP_AUTH_TOKEN'] = "#{@user.auth_token}"

        post :create, session: { email: "sing@song.com" , password: "thebestyoueverhad" }
      end

      it "should have a 201 status" do
        expect(response).to have_http_status 201
      end

      it "renders a JSON of the logged in user" do
        body = response.body
        user = User.last.to_json
        expect(body).to eql user
      end
    end

    context "when is not created" do
      before(:each) do

        @user = User.create(name: "Jigglypuff", email: "sing@song.com", password: "thebestyoueverhad", password_confirmation: "thebestyoueverhad")

        request.headers['Accept'] = "application/json"
        request.headers['Content-Type'] = "application/json"
        request.env['HTTP_NAME'] = "#{@user.name}"
        request.env['HTTP_AUTH_TOKEN'] = "#{@user.auth_token}"
        # same as above but user was never created
        post :create, session: { email: "sing@song.com" , password: "differentpassword" }
      end

      it "responds with a 401 unauthorized status" do
        expect(response).to have_http_status 401
      end
    end
  end
end
