require 'rails_helper'

RSpec.describe Job, type: :model do
    it "is valid with a title, description, job_category, location, job_author, job_company, salary, user_id" do
      user = User.create(role: true, name: "John Doe", email: "johndoe@example.com", password: "ram123", password_confirmation: "ram123")
      job = Job.new(title: "Full Stack Developer", description: "This is a job", job_category: "Computer Science", location: "Indore", job_author: "Ram", job_company: "Tcs", salary: 4, user_id: user.id)
      expect(job).to be_valid
    end
    

    it "is not valid with a title, description, job_category, location, job_author, job_company, salary" do
      user = User.create(role: true, name: "John Doe", email: "johndoe@example.com", password: "ram123", password_confirmation: "ram123")
      job = Job.new(title: "Full Stack Developer", description: "This is a job", job_category: "Computer Science", location: "Indore", job_author: "Ram", job_company: "Tcs", salary: 4)
      expect(job).to_not be_valid
    end

    it "is not valid with a title, description, user_id" do
      user = User.create(role: true, name: "John Doe", email: "johndoe@example.com", password: "ram123", password_confirmation: "ram123")
      job = Job.new(title: "Full Stack Developer", description: "This is a job",user_id: user.id)
      expect(job).to_not be_valid
    end

    it "is not valid with a job_category, location, job_author, job_company, salary, user_id" do
      user = User.create(role: true, name: "John Doe", email: "johndoe@example.com", password: "ram123", password_confirmation: "ram123")
      job = Job.new(job_category: "Computer Science", location: "Indore", job_author: "Ram", job_company: "Tcs", salary: 4 ,user_id: user.id)
      expect(job).to_not be_valid
    end

    it "belongs to a user" do
      job = Job.reflect_on_association(:user)
      expect(job.macro).to eq(:belongs_to)
    end

    it "has many applies" do
      job = Job.reflect_on_association(:applies)
      expect(job.macro).to eq(:has_many)
    end
    
end

