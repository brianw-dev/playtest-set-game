require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let!(:user) {User.create!(first_name: "Test", last_name: "tester", username: "TTest", email: "test@test.com", password: "123456")}

  describe "GET #index" do

    it "assigns all users as @users" do
      all_users = User.all
      get :index
      expect(assigns(:users)).to eq all_users
    end

    it "renders the :index template" do
        get :index
        expect(response).to render_template("index")
    end

    it "responds with status code 200" do
        get :index
        expect(response).to have_http_status 200
    end

  end

  describe "GET #new" do

    it "responds with status code 200" do
      get :new
      expect(response).to have_http_status 200
    end

    it "assigns a new user to @user" do
      get :new
      expect(assigns(:user)).to be_a_new User
    end

    it "renders the :new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    context "when valid params are passed" do

      before do
        post :create, params: { user: { first_name: "Test2", last_name: "Tester", username: "TTester", email: "test2@test.com", password: "123456"} }
      end

      it "responds with status code 302" do
        expect(response).to have_http_status 302
      end

      it "creates a new user in the database" do
        expect(User.count).to eq 2
      end

      it "assigns the newly created user as @user" do
        latest_user = User.last
        expect(assigns(:user)).to eq latest_user
      end
      it "sets a notice that the user was successfully created" do
        expect(flash[:notice]).to match /User was successfully created./
      end

      it "redirects to the created user" do
        expect(response).to redirect_to root_path
      end
    end

    context "when invalid params are passed" do
      before do
        post :create, params:{ user: { first_name: "pineapple" } }
      end

      it "responds with status code 422: Unprocessable Entity" do
        expect(response).to have_http_status 422
      end

      it "does not create a new user in the database" do
        expect(User.count).to eq 1
      end

      it "assigns the unsaved user as @user" do
        get :new
        expect(assigns(:user)).to be_a_new User
      end

      it "renders the :new template" do
        expect(response).to render_template(:new)
      end
    end
  end


  describe "GET 'show'" do

    before do
      User.should_receive(:find).and_return(user)
    end

    it "assigns requested user as @user" do
      get 'show', params:{ id: user.id}

      assigns[:user].should eql(user)
    end

    it "renders 'show' template" do
      get 'show', params:{ id: user.id}

      response.should render_template("show")
    end

  end

  describe "GET 'edit'" do

    before do
      User.should_receive(:find).and_return(user)
    end

    it "assigns requested user as @user" do
      get 'edit', params: { id: user.id}

      assigns[:user].should eql(user)
    end

    it "renders 'edit' template" do
      get 'edit', params: { id: user.id}

      response.should render_template("edit")
    end

  end

  describe "POST 'update'" do

    before do
      User.should_receive(:find).and_return(user)
    end

    context "update successful" do

      before(:each) do
        user.stub(:update_attributes).and_return(true)
      end

      it "redirects to users list" do
        post "update", id: user.id, user: { :email => "new@example.com" }

        response.should redirect_to(:user)
      end

      it "sets notice on successful update" do
        post "update", id: user.id, user: { :email => "new@example.com" }

        flash[:notice].should_not be_nil
      end

    end

    context "update failed" do

      before(:each) do
        user.stub(:update_attributes).and_return(false)
      end

      it "renders 'edit' template" do
        post "update", id: user.id, user: { :email => "new@example.com" }

        response.should render_template("edit")
      end

    end

  end

  describe "POST 'destroy'" do

    before do
      User.should_receive(:find).and_return(user)
    end

    it "redirects to users list" do
      delete "destroy", :id => user.id

      response.should redirect_to(users_url)
    end

    it "sets notice on successful destroy" do
      delete 'destroy', :id => user.id

      flash[:success].should_not be_nil
    end

  end

end
