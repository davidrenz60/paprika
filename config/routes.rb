Rails.application.routes.draw do
  root to: "recipes#index"

  resources :recipes, only: [:index, :show] do
    post '/send_email', to: "recipes#send_email"
    collection do
      post "sync"
    end
  end

  resources :categories, only: [:index, :show]


  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  post '/logout', to: "sessions#destroy"
end
