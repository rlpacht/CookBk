Rails.application.routes.draw do
  resources :user_favorites
  resources :users
  resources :recipes
  root 'application#index'
  post "/sessions", to: "sessions#create"
end
