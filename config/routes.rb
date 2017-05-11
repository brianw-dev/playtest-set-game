Rails.application.routes.draw do
  root "users#index"
  resources :games
  resources :users
  resources :sessions, only: [:new,:create,:destroy]
end
