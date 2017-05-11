Rails.application.routes.draw do
  root "users#index"

  resources :users
  resources :sessions, only: [:new,:create,:destroy]
  resources :games
end
