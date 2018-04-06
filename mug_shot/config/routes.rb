Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

root to: "products#index"

resources :carts
resources :products
devise_for :users
resources :users
end
