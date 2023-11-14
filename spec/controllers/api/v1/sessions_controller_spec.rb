require "rails_helper"

RSpec.describe Api::V1::SessionsController, type: :controller do
    let(:user) { User.create(role: true, name: "John Doe", email: "johndoe@example.com", password:"john123", password_confirmation:"john123",admin:true)}
    
    describe "SessionsController#create" do
     context "user can be created" do
      it "create the user" do
        post :create, params: { user: {role: true, name: "Rakesh", email: "rakesh@example.com", password: "rakesh123", password_confirmation: "rakesh123"}  }
        expect(response).to have_http_status(:success)
        expect(response.body).to include('token')
      end
     end
    end

    describe "SessionsController#login" do
     context "user can login" do
      it "login the user" do

        user_to_login = User.create(role: true, name: "Rakesh", email: "rakesh@example.com", password: "rakesh123", password_confirmation: "rakesh123")

        post :login, params: { email: "rakesh@example.com", password: "rakesh123" }
        expect(response).to have_http_status(:ok)
        expect(response.body).to include('token')
      end
     end
    end
end