require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
 let!(:user) {User.create!(first_name: "Test", last_name: "tester", username: "TTest", email: "test@test.com", password: "123456", phone_number: '+18765432100')}
  describe "GET new" do
    it "responds with status code 200" do
      get :new
      expect(response).to have_http_status(200)
    end
  end

  describe "POST create" do
    it "login a user" do
      expect{ post :create, params: {session: {username: "TTest", password: "123456"}}}.to change{session[:id]}.from(nil)
    end
  end

  describe "POST create" do
    it "fails to login a user" do
      expect{post :create, params: {session: {username: "Test", password: "123456"}}}.to_not change{session[:id]}.from(nil)
    end
  end

  describe "POST destroy" do
    context "When the user logout" do
      it "the session ends" do
        post :destroy, id: user.id
        expect(session[:id]).to be_nil
      end
    end
  end
end
