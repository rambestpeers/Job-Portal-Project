# frozen_string_literal: true

Rails.application.routes.draw do
  resources :jobs do
    collection do
      get 'my_jobs'
    end
    resources :apply, only: %i[new create]
  end

  resources :apply, only: %i[index show] do
    member do
      get 'accept'
      get 'reject'
    end
  end

  devise_for :users, controllers: { registrations: 'registrations' }
  root to: 'home#index'

  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
  end

  devise_scope :user do
    get 'signup', to: 'devise/registrations#new'
  end

  devise_scope :user do
    get '/users/sign_out', to: 'devise/sessions#destroy'
  end

  # Routes for APIs
  namespace :api do
    namespace :v1 do
      resources :jobs do
        collection do
          get 'my_jobs'
        end
        resources :apply, only: %i[new create]
      end

      resources :apply, only: %i[index show] do
        member do
          get 'accept'
          get 'reject'
        end
      end

      # devise_for :users, :controllers => {:registrations => "registrations"}
      devise_for :users
      post '/login', to: 'sessions#login'
      root to: 'home#index'
    end
  end
end
