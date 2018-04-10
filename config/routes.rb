Rails.application.routes.draw do
  root to: "recipes#index"

  resources :recipes, only: [:index, :show] do
    collection do
      post "sync"
    end
  end
end
