Rails.application.routes.draw do
  resources :users
  resources :orders
  resources :line_items
  resources :carts
  root 'store#index', as: 'store_index' 
  resources :products
  
end
