Rails.application.routes.draw do
  get "/my_products", to: "products#my_products", as: :my_products
  get '/orders', to: 'orders#index'
  devise_for :users
  root to: 'products#index'
  resources :products do
    resources :orders, except: [:index] do
      resources :reviews, except: [:index, :show, :edit, :update]
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
