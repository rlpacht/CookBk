Rails.application.routes.draw do
  namespace :api do
    resources :user_favorites, :only => [:create, :destroy, :index]
    resources :users
    resources :recipes, :only => [:index, :show]
    post "sessions", to: "sessions#create"
  end
  root 'application#index'
  
end
