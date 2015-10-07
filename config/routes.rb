Rails.application.routes.draw do
  # resources :users

  namespace :api do
    resources :user_favorites, :only => [:create, :destroy, :index]
    resources :recipes, :only => [:index, :show]
    resources :notes, :only => [:index, :create, :destroy, :update, :show]
  end

  root 'application#index'

  get "/users/new", to: "users#new"#, as: "signup"

  post "users", to: "users#create"

  get "sessions/new", to: "sessions#new"

  post "sessions", to: "sessions#create"

  delete "sessions", to: "sessions#destroy"

  get '*path' => 'application#index'
end
