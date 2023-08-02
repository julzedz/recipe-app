Rails.application.routes.draw do
  devise_for :users
  root 'users#index'
  resources :users
  resources :foods
  resources :recipes, only: [:index, :show, :new, :create, :destroy]
  resources :users, only: [:index, :show]
  resources :public_recipes, only: [:index]
  resources :shopping_lists, only: [:index]
end




Rails.application.routes.draw do
  
end