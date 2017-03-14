Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users
  root 'main#index'
  get 'main/index',to: 'main#index'
  resources :auctions
  resources :products

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
