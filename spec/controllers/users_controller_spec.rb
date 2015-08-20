require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "POST #create" do
    context "when is successfully created" do
      before(:each) do
        @user_attributes = { name: "Jon Snow", email: "north@thewall.com", password: "knowNothing", password_confirmation: "knowNothing" }
        post :create, user: @user_attributes
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
end
