Rails.application.routes.draw do
  devise_for :users
  root 'users#index'
  resources :users
  resources :foods, only: [:index,:new, :create, :destroy]
  resources :recipes, only: [:index, :show, :new, :create, :destroy]
  resources :users, only: [:index, :show]
  resources :public_recipes, only: [:index]
  resources :shopping_lists, only: [:index]
end
