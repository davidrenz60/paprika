Rails.application.routes.draw do
  root to: "recipes#index"

  resources :recipes, only: [:index, :show] do
    collection do
      post "sync"
    end
  end

  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  post '/logout', to: "sessions#destroy"
end
