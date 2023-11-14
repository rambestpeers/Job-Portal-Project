require "rails_helper"
require_relative "../../../support/devise"

RSpec.describe Api::V1::JobsController, type: :controller do
  let(:user) { User.create(role: true, name: "Shiva", email: "shiva@example.com", password:"john123", password_confirmation:"john123",admin:true)}
  let(:job) {Job.create(title: "Full Stack Developer", description: "This is a job", job_category: "Computer Science", location: "Indore", job_author: "Ram", job_company: "Tcs", salary: 4, user_id: user.id)}

  before do
    request.headers['Authorization'] = "Bearer #{AuthenticationTokenService.encode_token(user.id)}"
  end

  describe "JobsController#index" do
    context "users can see jobs" do
      it "returns a JSON response with all events" do
        get :index
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(/application\/json/)
      end
    end

    # context "user can filter jobs" do
    #   it "render through panel template" do
    #     get :index, params: {job_category: {job_category: "Computer Science"}}
    #     expect(response).to have_http_status(:ok)
    #   end
    # end
  end

  describe "JobsController#show" do
   context "show the job" do
    it 'render show' do
      get :show, params: { id: job.id }
      expect(response).to be_successful
    end
   end
  end

  describe  "JobsController#create" do    
    context "recruiter can create job" do
      it "create the job" do
        post :create, params: { job: {title: "Civil Engineer 1", description: "this is job", job_category: "civil", location: "Dehradhun", job_author: "Praveen", job_company: "Techno", salary: 4} }
        expect(response).to have_http_status(:success)
      end
    end
  end
 
  describe  "JobsController#update" do    
    context "recruiter can update job" do
      it "update the job" do
        patch :update, params: {id: job.id, job: { title: "xyz"}, format: :json}
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(/application\/json/)
        expect(JSON.parse(response.body)["title"]).to eq("xyz")
        job.reload
        expect(job.title).to eq("xyz")
      end
    end
  end


  describe  "JobsController#destroy" do    
    context "recruiter can destroy job" do
      it "destroy the job" do
        delete :destroy, params: { id: job.id, format: :json}
        expect(response).to have_http_status("204")
      end
    end
  end

  describe  "JobsController#my_jobs" do    
    context "recruiter can see their jobs" do
      it "show the jobs" do
        get :my_jobs, params: {user_id: user.id}
        expect(response).to be_successful 
      end
    end
  end
end
