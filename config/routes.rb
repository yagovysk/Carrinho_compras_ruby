Rails.application.routes.draw do
  get 'support_requests/index'
  get 'admin' => 'admin#index'
  
  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  get 'sessions/create'
  get 'sessions/destroy'

  resources :support_requests, only: %i[ index update ]

  resources :users
  resources :products do
    get :who_bought, on: :member
  end

  scope '(:locale)' do  # Adicionando o escopo opcional do idioma
    resources :orders
    resources :line_items
    resources :carts
    root 'store#index', as: 'store_index', via: :all
  end
end
