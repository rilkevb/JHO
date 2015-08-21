require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe "GET #new" do
    @user = User.new
    it "should load a new user" do
      expect(assigns(:user)).to match(@user)
    end
  end

  describe "POST #create" do
    context "when is successfully created" do
      before(:each) do
        @user = User.create(name: "Jigglypuff", email: "sing@song.com", password: "thebestyoueverhad", password_confirmation: "thebestyoueverhad")

        post :create, user: { email: "sing@song.com" , password: "thebestyoueverhad"
      end
    end
    context "when is not created" do
      expect(response).to render_template(:new)
    end
  end
end
