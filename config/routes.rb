Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :stories
      post 'auth/login', to: 'authentication#authenticate'
      post 'signup', to: 'users#create'
    end
  end

  namespace :admin do
    resources :categories
    resources :tags
    resources :users

    root to: "users#index"
  end

  namespace :dashboard, path: '/ud' do
    resources :inspirations, only: [:index, :create, :destroy]
    resources :messages
    resources :comments
    resources :brands
    resources :reviews, only: [:index, :create]
    resources :stories, only: [:index, :create]
    resource :profile do
      member do
        put :update_password
      end
    end
  end

  get '/dashboard', to: 'dashboard#index', as: :dashboard

  devise_for :users, controllers: { sessions:      'users/sessions',
                                    registrations: 'users/registrations',
                                    passwords:     'users/passwords',
                                    omniauth_callbacks: 'users/omniauth'
                   }
  resources :users, only: [:show] do
    collection do
      post :varify_handle
    end
  end
  resources :stories, only: [:show]
  get ':handle', to: 'users#home', as: :user_profile
  root to: 'home#index'
end
