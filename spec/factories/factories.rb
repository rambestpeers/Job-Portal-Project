FactoryBot.define do
    factory :user do
      role { true }
      name { "Akshay"}
      email { "akshay2@example.com" }
      password { "akshay123" }
      password_confirmation {"akshay123"}
    end
end