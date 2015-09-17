Rails.application.routes.draw do
  resources :users
  resources :recipes
  get  "/search", to: "recipes#search"
  root 'application#index'
end
