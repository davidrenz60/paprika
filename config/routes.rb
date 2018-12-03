Rails.application.routes.draw do
  root to: "recipes#index"

  resources :recipes, only: [:index, :show] do
    resources :comments, only: [:create, :index]

    get '/favorite', to: 'favorites#create'
    get '/unfavorite', to: 'favorites#destroy'

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

  get '/register', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  post '/logout', to: 'sessions#destroy'
end
