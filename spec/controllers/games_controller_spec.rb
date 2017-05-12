require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  User.create(first_name: "Billy", last_name: "Bob", username: "bob", email: "bob@gmail.com", password: "billybob")
  let!(:current_user) { User.first }
  let!(:game) { Game.create(user_id: 1) }

  describe "GET #index" do
    it "responds with status code 200" do
      get :index
      expect(response).to have_http_status 200
    end

    it "assigns the all games as @games" do
      get :index
      expect(assigns(:games)).to eq(Game.all)
    end
    it "renders the :index template" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    it "responds with status code 200" do
      get :show, params: { id: game.id }
      expect(response).to have_http_status 302
    end

    it "redirects to the edit game path" do
      get :show, params: { id: game.id }
      expect(response).to redirect_to(edit_game_path(Game.last))
    end
  end

  describe "GET #new" do
    it "responds with status code 200" do
      get :new
      expect(response).to have_http_status 200
    end

    it "assigns a new game to @game" do
      get :new
      expect(assigns(:game)).to be_a_new Game
    end

    it "renders the :new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    context "when valid params are passed" do
      it "responds with status code 302" do
        session[:id] = 1
        post(:create, params: { game: { user_id: current_user.id }})
        expect(response).to have_http_status 302
      end

      it "creates a new game in the database" do
        initial= Game.all.length
        session[:id] = 1
        post(:create, params: { game: { user_id: current_user.id }})
        expect(Game.all.length).to eq (initial + 1)
      end

      it "assigns the newly created game as @game" do
        session[:id] = 1
        post :create
        expect(assigns(:game)).to eq(Game.last)
      end

      it "redirects to the created game" do
        session[:id] = 1
        post :create, params: { game: { user_id: 1 } }
        expect(response).to redirect_to(edit_game_path(Game.last))
      end
    end
  end

  describe "GET #edit" do
    it "responds with status code 200" do
      get :edit, params: { id: game.id }
      expect(response).to have_http_status 200
    end

    it "assigns a game to @game" do
      get :edit, params: { id: game.id }
      expect(assigns(:game)).to eq(Game.last)
    end

    it "renders the :edit template" do
      get :edit, params: { id: game.id }
      expect(response).to render_template(:edit)
    end
  end

  # describe "POST #update" do
  #   context "when valid params are passed" do
  #     it "responds with status code 302" do
  #       post(:update, params: { game: { user_throw: "paper" }})
  #       expect(response).to have_http_status 302
  #     end

  #     it "updates a new game in the database" do
  #       initial= Game.all.length
  #       post(:update, params: { game: { user_throw: "paper" }})
  #       expect(Game.all.length).to eq (initial + 1)
  #     end

  #     it "assigns the newly updated game as @game" do
  #       post :update
  #       expect(assigns(:game)).to eq(Game.last)
  #     end

  #     it "redirects to the updated game" do
  #       post :update, params: { game: { user_throw: "paper" } }
  #       expect(response).to redirect_to(edit_game_path(Game.last))
  #     end
  #   end
  # end

end
