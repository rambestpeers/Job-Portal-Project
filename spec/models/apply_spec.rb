# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Apply, type: :model do
  it 'is valid with a name, skills, about_yourself, education, job_id, user_id' do
    user = User.create(role: true, name: 'John Doe', email: 'johndoe@example.com', password: 'ram123',
                       password_confirmation: 'ram123')
    job = Job.create(title: 'Full Stack Developer', description: 'This is a job', job_category: 'Computer Science',
                     location: 'Indore', job_author: 'Ram', job_company: 'Tcs', salary: 4, user_id: user.id)
    apply = Apply.new(name: 'Ram', skills: 'Ruby,Rails', about_yourself: 'My name is Ram', education: 'MCA',
                      job_id: job.id, user_id: job.user_id)
    expect(apply).to be_valid
  end

  it 'is not valid without a user_id and job_id' do
    user = User.create(role: true, name: 'John Doe', email: 'johndoe@example.com', password: 'ram123',
                       password_confirmation: 'ram123')
    Job.create(title: 'Full Stack Developer', description: 'This is a job', job_category: 'Computer Science',
               location: 'Indore', job_author: 'Ram', job_company: 'Tcs', salary: 4, user_id: user.id)
    apply = Apply.new(name: 'Ram', skills: 'Ruby,Rails', about_yourself: 'My name is Ram', education: 'MCA')
    expect(apply).to_not be_valid
  end

  it 'is not valid without a name, skills, about_yourself, education' do
    user = User.create(role: true, name: 'John Doe', email: 'johndoe@example.com', password: 'ram123',
                       password_confirmation: 'ram123')
    job = Job.create(title: 'Full Stack Developer', description: 'This is a job', job_category: 'Computer Science',
                     location: 'Indore', job_author: 'Ram', job_company: 'Tcs', salary: 4, user_id: user.id)
    apply = Apply.new(job_id: job.id, user_id: job.user_id)
    expect(apply).to_not be_valid
  end

  it 'belongs to a user' do
    apply = Apply.reflect_on_association(:user)
    expect(apply.macro).to eq(:belongs_to)
  end

  it 'belongs to a job' do
    apply = Apply.reflect_on_association(:job)
    expect(apply.macro).to eq(:belongs_to)
  end

  # it "has one attached to resume" do
  #   apply = Apply.reflect_on_association(:resume)
  #   expect(apply.file).to be_attached
  # end
end
