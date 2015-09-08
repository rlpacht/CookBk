Rails.application.routes.draw do
  resources :users
  resources :recipes
  root 'application#index'
end
