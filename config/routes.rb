Rails.application.routes.draw do
  root to: 'products#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  
  resources :users do
    member do
      get :shoppings
      post :applyings
    end
  end
  
  resources :products do
    collection do
      get :stocks
    end
  end
  
  resources :purchases do
    member do
      get :complete
    end
  end
  
  resources :baskets, only: [:index, :create, :edit, :update, :destroy]
end
