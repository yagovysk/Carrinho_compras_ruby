Rails.application.routes.draw do
  post "locale/:locale", to: "application#change_locale", as: :change_locale
  get "questions", to: "pages#questions", as: :questions
  get "news", to: "pages#news", as: :news
  get "contact", to: "pages#contact", as: :contact

  resources :users
  resources :orders
  resources :line_items
  resources :carts
  root 'store#index', as: 'store_index' 
  resources :products
  
end
