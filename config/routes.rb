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

  namespace :agent_dashboard, path: '/ad' do
    resources :messages
    resources :brands
    resources :stories
    resources :reviews, only: [:index, :show]
  end

  namespace :dashboard, path: '/ud' do
    resources :inspirations, only: [:index, :create, :destroy]
    resources :messages
    resources :reviews, only: [:index, :create]
    resources :stories, only: [:index, :create]
    resource :profile do
      member do
        put :update_password
      end
    end
  end

  get '/dashboard', to: 'dashboard#index', as: :dashboard
  get '/agent_dashbord', to: 'dashboard#agent_index', as: :agent_dashbord

  devise_for :users, controllers: { sessions:      'users/sessions',
                                    registrations: 'users/registrations',
                                    passwords:     'users/passwords',
                   }
  resources :users, only: [:show]
  root to: 'visitors#index'
end
