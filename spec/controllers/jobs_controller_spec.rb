# frozen_string_literal: true

require 'rails_helper'
RSpec.describe JobsController, type: :controller do
  let(:user) do
    User.create(role: true, name: 'Rohan', email: 'rohan@example.com', password: 'rohan123',
                password_confirmation: 'rohan123', admin: true)
  end
  let(:job) do
    Job.create(title: 'Full Stack Developer', description: 'This is a job', job_category: 'Computer Science',
               location: 'Indore', job_author: 'Ram', job_company: 'Tcs', salary: 4, user_id: user.id)
  end
  describe 'JobsController#index' do
    context 'user can see jobs' do
      it 'renders the index template' do
        get :index
        expect(response).to render_template('index')
      end
    end

    context 'user can filter jobs' do
      it 'render through panel template' do
        get :index, params: { job_category: { job_category: 'Computer Science' } }
        expect(response).to have_http_status(200)
      end
    end
  end

  # describe 'JobsController#new' do
  #  context "get the new path" do
  #   it 'returns new' do
  #     sign_in(user)
  #     get :new
  #     expect(response).to be_successful
  #   end
  #  end
  # end

  describe 'JobsController#create' do
    context 'create jobs' do
      it 'renders the new template' do
        sign_in(user)
        post :create,
             params: { job: { title: 'Full Stack Developer', description: 'This is a job', job_category: 'Computer Science',
                              location: 'Indore', job_author: 'Ram', job_company: 'Tcs', salary: 4, user_id: user.id } }
        expect(response).to have_http_status(302)
      end

      it 'renders the new template in HTML format' do
        sign_in(user)
        post :create, params: { job: { title: 'Ful Stack Developer' } }
        expect(response).to render_template(:new)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'JobsController#show' do
    context 'show the job' do
      it 'render show' do
        sign_in(user)
        get :show, params: { id: job.id }
        expect(response).to be_successful
      end
    end
  end

  describe 'JobsController#update' do
    context 'when user is an admin' do
      it 'render the update template' do
        sign_in(user)
        patch :update, params: { id: job.id, job: { title: 'xyz' } }
        expect(response).to have_http_status(302)
      end
    end

    context 'with invalid parameters' do
      it 'renders the edit template in HTML format' do
        sign_in(user)
        patch :update, params: { id: job.id, job: { title: '' } }
        expect(response).to render_template(:edit)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'JobsController#destroy' do
    context 'when user is an admin' do
      it 'deletes the job and redirects to the jobs index' do
        sign_in(user)
        delete :destroy, params: { id: job.id }
        expect { job.reload }.to raise_error(ActiveRecord::RecordNotFound)
        expect(response).to redirect_to(jobs_url)
        expect(flash[:notice]).to eq('Job was successfully destroyed.')
      end
    end
  end

  describe 'JobsController#my_jobs' do
    context 'can se there jobs' do
      it 'renders the my_jobs tempelate' do
        sign_in(user)
        get :my_jobs, params: { user_id: user.id }
        expect(response).to be_successful
      end
    end
  end
end
