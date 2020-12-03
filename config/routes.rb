Rails.application.routes.draw do
  get "/my_products", to: "products#my_products", as: :my_products
  get '/orders', to: 'orders#index'
  devise_for :users
  root to: 'products#index'
  resources :products do
    resources :orders, only: [:new, :create]
  end
  resources :orders, only: [:edit, :show, :update, :destroy] do
    resources :reviews, only: [:create, :new]
  end
  resources :reviews, only: [:destroy]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
