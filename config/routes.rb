Rails.application.routes.draw do
  get 'users/index'
  get "/my_products", to: "products#my_products", as: :my_products
  devise_for :users
  root to: 'products#index'
  resources :products do
    resources :orders, except: [:index]
  end
  get '/orders', to: 'orders#index'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
