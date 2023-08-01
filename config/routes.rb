Rails.application.routes.draw do
  resources :users
  root "home#index"
  devise_for :users
end
