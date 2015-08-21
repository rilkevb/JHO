require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do
  describe 'GET #index' do
    context 'when user is logged in' do
      before do
        user = User.create(name: "The Doctor", email: "doctor@thetardis.com", password: "Fantastic!", password_confirmation: "Fantastic!")
        session[:user_id] = user.id
        get :index
      end
      it { is_expected.to redirect_to boards_path }
    end
    context 'when user is logged out' do
      before do
        get :index
      end
      it { is_expected.to respond_with :success }
      it { is_expected.to render_with_layout :application }
      it { is_expected.to render_template :index }
    end
  end
end
