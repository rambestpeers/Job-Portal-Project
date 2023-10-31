Rails.application.routes.draw do
  resources :jobs do
    collection do
      get 'my_jobs' 
    end
    
    resources :apply, only: [:new, :create] 
        
   
  end
  
  resources :apply, only: [:index, :show] do
    member do
      get 'accept'
      get 'reject'
    end
  
  end
  
  devise_for :users, :controllers => {:registrations => "registrations"}
  root to: 'home#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
  end

  devise_scope :user do
    get 'signup', to: 'devise/registrations#new'
  end

  devise_scope :user do
    get '/users/sign_out', to: 'devise/sessions#destroy'
  end

  
  
end
