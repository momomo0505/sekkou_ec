Rails.application.routes.draw do
  devise_for :users
  root to: 'items#index'

  resources :items do
    resources :comments, only: :create
    delete 'remove_item/:item_id', to: 'users#remove_item', as: 'remove_item'
    resources :orders, only: [:index, :create] 
    member do
      post :add_to_cart
    end
    end

    resources :users, only: :show
   end
