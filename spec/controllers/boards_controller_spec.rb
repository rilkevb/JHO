require "rails_helper"

RSpec.describe BoardsController, :type => :controller do

  let(:user) { User.create(name: "Matt") }
  let(:board_1) { user.boards.create(name: "Software Developer Job Hunt", user_id: user.id) }
  let(:list_1) { List.create(board_id: board_1.id, name: "Organizations of Interest", position_id: 1) }
  let(:list_2) { List.create(board_id: board_1.id, name: "Finding Advocate", position_id: 2) }
  let(:list_3) { List.create(board_id: board_1.id, name: "Initial Application", position_id: 3) }
  let(:list_4) { List.create(board_id: board_1.id, name: "Cultural Interview", position_id: 4) }
  let(:list_5) { List.create(board_id: board_1.id, name: "Tech Screen/Code Challenge", position_id: 5) }
  let(:list_6) { List.create(board_id: board_1.id, name: "Onsite", position_id: 6) }

  let(:card_1) { Card.create(list_id: 1, organization_name: "Google") }
  let(:card_2) { Card.create(list_id: 1, organization_name: "ZenPayroll") }
  let(:card_3) { Card.create(list_id: 2, organization_name: "Adobe") }
  let(:card_4) { Card.create(list_id: 2, organization_name: "Facebook") }
  let(:card_5) { Card.create(list_id: 2, organization_name: "Wired") }
  let(:card_6) { Card.create(list_id: 2, organization_name: "Make") }
  let(:card_7) { Card.create(list_id: 3, organization_name: "Amazon") }

  let(:card_8) { list1.cards.new organization_name: "Dev Bootcamp"}

  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index, { :id => board_1.id, :user_id => user.id  }
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      get :index, { :id => board_1.id, :user_id => user.id  }
      expect(response).to render_template("index")
    end

    it "finds and loads the current user" do
      get :index, { :id => board_1.id, :user_id => user.id  }
      expect(assigns(:user)).to match(user)
    end

    it "loads all of the user's boards" do
      get :index, { :id => board_1.id, :user_id => user.id  }
      expect(assigns(:boards)).to match_array([board_1])
    end
  end

  describe "GET #show" do
    it "responds successfully with an HTTP 200 status code" do
      get :show, { :id => board_1.id, :user_id => user.id  }
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the show template" do
      get :show, { :id => board_1.id, :user_id => user.id  }
      expect(response).to render_template("show")
    end

    it "finds and loads the current user" do
      expect(assigns(:user)).to match(user)
    end

    it "finds loads the current board" do
      expect(assigns(:board)).to match(board_1)
    end

    it "loads all of the lists into @lists" do
      get :show
      expect(assigns(:lists)).to match_array([list1, list2, list3, list4, list5, list6])
    end
  end
end
