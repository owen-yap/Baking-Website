Rails.application.routes.draw do
  get "/users/:id/products", to: "users#index", as: :user_products
  devise_for :users
  root to: 'products#index'
  resources :products do
    resources :orders, except: [:index]
  end
  get '/orders', to: 'orders#index'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
