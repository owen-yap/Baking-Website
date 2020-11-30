Rails.application.routes.draw do
  get 'products/edit'
  get 'products/update'
  get 'products/destroy'
  root to: 'pages#home'

  resources :products
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
