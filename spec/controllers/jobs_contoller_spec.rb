require "rails_helper"
RSpec.describe JobsController, type: :controller do
  let(:user) { User.create(role: true, name: "John Doe", email: "johndoe@example.com", password:"john123", password_confirmation:"john123")}
  
  describe "JobsController#index" do
  context "user can see jobs" do
    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
   end
  end

  describe "JobsController#create" do
  context "create jobs" do
    it "renders the show template" do
        
      sign_in(user)
      post :create, params:{ job: { title: "Full Stack Developer", description: "This is a job", job_category: "Computer Science", location: "Indore", job_author: "Ram", job_company: "Tcs", salary: 4, user_id: user.id} }
      
      expect(response).to have_http_status(302)
    
    end
   end
  end
end

