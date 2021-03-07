Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  resources :periodicities, only: %i[index create update edit destroy]
  resources :product_types, only: %i[index create update edit destroy]
end
