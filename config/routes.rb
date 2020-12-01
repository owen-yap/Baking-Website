Rails.application.routes.draw do
  get "/users/:id/products", to: "users#index", as: :user_products
  devise_for :users
  root to: 'products#index'
  resources :products 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
