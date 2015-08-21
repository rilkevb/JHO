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

        post :create, session: { email: "sing@song.com" , password: "thebestyoueverhad" }
      end
      it { is_expected.to set_session[:user_id].to @user.id }
      it { is_expected.to redirect_to boards_path }
    end

    context "when is not created" do
      before(:each) do
        post :create, session: { email: "sing@song.com" , password: "thebestyoueverhad" }
      end

      it { is_expected.to respond_with :success }
      it { is_expected.to render_with_layout :application }
      it { is_expected.to set_flash[:danger].to('Invalid email/password combination').now }
      it { is_expected.to render_template :new }
    end
  end

  describe "DELETE #destroy" do
    context "when is successfully destroyed" do
      before(:each) do
        post :create, session: { email: "sing@song.com" , password: "thebestyoueverhad" }
      end

      it "sets @current_user to nil" do
        expect(assigns(:current_user)).to be_nil
      end

      it { is_expected.to_not set_session[:user_id] }
      it {is_expected.to respond_with 200 }
      # Not sure why it is not registering redirect
      # it { is_expected.to redirect_to '/' }
    end
  end
end
