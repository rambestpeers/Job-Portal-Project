# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::ApplyController, type: :controller do
  let(:recruiter) do
    User.create(role: true, name: 'Sanjay', email: 'sanjay@example.com', password: 'john123',
                password_confirmation: 'john123', admin: true)
  end
  let(:user) do
    User.create(role: false, name: 'Mohan', email: 'mohan@example.com', password: 'john123',
                password_confirmation: 'john123', admin: true)
  end
  let(:job) do
    Job.create(title: 'Full Stack Developer', description: 'This is a job', job_category: 'Computer Science',
               location: 'Indore', job_author: 'Ram', job_company: 'Tcs', salary: 4, user_id: recruiter.id)
  end
  let(:apply) do
    Apply.create(name: 'abc', about_yourself: 'hiii', skills: 'abc', education: 'tech', user_id: user.id,
                 job_id: job.id)
  end

  describe 'ApplyController#index' do
    context 'users can see jobs' do
      it 'returns a JSON response with all events' do
        request.headers['Authorization'] = "Bearer #{AuthenticationTokenService.encode_token(user.id)}"
        get :index
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(%r{application/json})
      end
    end
  end

  describe 'ApplyController#create' do
    context 'create application' do
      it 'renders the new template' do
        request.headers['Authorization'] = "Bearer #{AuthenticationTokenService.encode_token(user.id)}"
        post :create,
             params: { user_id: user.id, job_id: job.id,
                       apply: { name: 'abc', about_yourself: 'hiii', skills: 'abc', education: 'tech' } }
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'ApplyController#accept' do
    context 'recruiter can accept the application' do
      it 'update the status' do
        request.headers['Authorization'] = "Bearer #{AuthenticationTokenService.encode_token(recruiter.id)}"
        get :accept, params: { id: apply.id }
        apply.reload
        expect(apply.status).to eq('accepted')
      end
    end
  end

  describe 'ApplyController#reject' do
    context 'recruiter can accept the application' do
      it 'update the status' do
        request.headers['Authorization'] = "Bearer #{AuthenticationTokenService.encode_token(recruiter.id)}"
        get :reject, params: { id: apply.id }
        apply.reload
        expect(apply.status).to eq('rejected')
      end
    end
  end
end
