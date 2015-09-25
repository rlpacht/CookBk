Rails.application.routes.draw do
  resources :user_favorites, :only => [:create, :destroy, :index]
  resources :users
  resources :recipes, :only => [:index, :show]
  root 'application#index'
  post "sessions", to: "sessions#create"
end
