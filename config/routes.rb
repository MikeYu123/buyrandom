Rails.application.routes.draw do
  get 'user/show'

  get 'user/edit'

  post 'user/update'

  get 'user/reset_password'

  get 'user/deposit'

  ActiveAdmin.routes(self)
  devise_for :user
  root 'main#index'
  get 'main/index',to: 'main#index'
  resources :auctions do
    member do
      post :bid
    end
  end
  resources :products

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
