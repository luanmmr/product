Rails.application.routes.draw do
  devise_for :users
  get '/apis', to: 'apis#index'
  root to: 'home#index'
  resources :periodicities, only: %i[index create update edit destroy]
  resources :product_types, only: %i[index create update edit destroy]
  resources :plans, only: %i[index create update edit destroy] do
    post 'deactivate', 'activate', on: :member
  end
  resources :prices, only: %i[index create update edit destroy]

  namespace 'api' do
    namespace 'v1' do
      resources :periodicities, only: :index
      resources :product_types, only: %i[index show] do
        resources :plans, only: :index, action: :product_type
      end
      resources :plans, only: %i[index show] do
        resources :prices, only: :index
      end
    end
  end
end
