Rails.application.routes.draw do
  root to: "recipes#index"

  resources :recipes, only: [:index, :show] do
    resources :comments, only: [:create, :index]

    post '/favorite', to: 'favorites#create'
    delete '/unfavorite', to: 'favorites#destroy'

    member do
      post :send_email
    end

    collection do
      post "sync"
    end
  end

  resources :categories, only: [:index, :show]

  resources :users, only: [:create]
  resources :favorites, only: [:index]
  resources :invitations, only: [:new, :create]

  get '/forgot_password', to: 'forgot_passwords#new'
  get '/invalid_token', to: 'pages#invalid_token'
  get '/expired_token', to: 'pages#expired_token'
  resources :forgot_passwords, only: [:create]
  resources :reset_passwords, only: [:show, :create], param: :token

  get '/register', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  post '/logout', to: 'sessions#destroy'
end
