# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplyController, type: :controller do
  let(:user) do
    User.create(role: false, name: 'John Doe', email: 'johndoe@example.com', password: 'john123',
                password_confirmation: 'john123')
  end
  let(:recruiter) do
    User.create(role: true, name: 'Ram Sharma', email: 'ram@example.com', password: 'john123',
                password_confirmation: 'john123')
  end
  let(:job) do
    Job.create(title: 'Full Stack Developer', description: 'This is a job', job_category: 'Computer Science',
               location: 'Indore', job_author: 'Ram', job_company: 'Tcs', salary: 4, user_id: user.id)
  end
  let(:apply) do
    Apply.create(name: 'abc', about_yourself: 'hiii', skills: 'abc', education: 'tech', user_id: user.id,
                 job_id: job.id)
  end
  describe 'ApplyController#index' do
    context 'user can see applied jobs' do
      it 'renders the index template' do
        sign_in(user)
        get :index
        expect(response).to render_template('index')
      end
    end
  end

  # describe "ApplyController#new" do
  #  context "user can initialize with new job" do
  #   it "return new" do
  #     sign_in(user)
  #     get :new
  #     expect(response).to render_template("form")
  #   end
  #  end
  # end

  describe 'ApplyController#create' do
    context 'create application' do
      it 'renders the new template' do
        sign_in(user)
        post :create,
             params: { user_id: user.id, job_id: job.id,
                       apply: { name: 'abc', about_yourself: 'hiii', skills: 'abc', education: 'tech' } }
        expect(response).to have_http_status(302)
      end

      it 'renders the new template when data is wrong' do
        sign_in(user)
        post :create, params: { user_id: user.id, job_id: job.id, apply: { name: 'abc' } }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'ApplyController#accept' do
    context 'recruiter can accept the application' do
      it 'update the status' do
        sign_in(recruiter)

        get :accept, params: { id: apply.id }
        apply.reload
        expect(apply.status).to eq('accepted')
      end
    end
  end

  describe 'ApplyController#reject' do
    context 'recruiter can accept the application' do
      it 'update the status' do
        sign_in(recruiter)
        get :reject, params: { id: apply.id }
        apply.reload
        expect(apply.status).to eq('rejected')
      end
    end
  end
end
