require 'rails_helper'

RSpec.describe User, type: :model do
    it "is valid with a role, name, email, password, password_confirmation" do
      user = User.new(role: true, name: "John Doe", email: "johndoe@example.com", password: "ram123", password_confirmation: "ram123")
      expect(user).to be_valid
    end

    it "is not valid without a name, email, password, password_confirmation" do
        user = User.new(name: "johndoe", email: "johndoe@example.com", password: "ram123", password_confirmation: "ram123")
        expect(user).to_not be_valid
    end

    it "is not valid without a name, email" do
        user = User.new(name: "johndoe", email: "johndoe@example.com")
        expect(user).to_not be_valid
    end

    it "is not valid without a role" do
        user = User.new(role: true)
        expect(user).to_not be_valid
    end

    it "is not valid without a email" do
        user = User.new(email: "johndoe@example.com")
        expect(user).to_not be_valid
    end

    it "is not valid without a name" do
        user = User.new()
        expect(user).to_not be_valid
    end

    it "is not valid without a password" do
        user = User.new(password: "ram123")
        expect(user).to_not be_valid
    end
    
    it "is not valid without a password confirmation" do
        user = User.new(password_confirmation: "ram123")
        expect(user).to_not be_valid
    end

    it "has many jobs" do
        user = User.reflect_on_association(:jobs)
        expect(user.macro).to eq(:has_many)
    end

    it "has many applies" do
        user = User.reflect_on_association(:applies)
        expect(user.macro).to eq(:has_many)
    end
end