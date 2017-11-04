Rails.application.routes.draw do
  devise_for :users
  resources :organizations, except: :destroy
  resources :campaigns #, only: [:index, :show, :new, :create]
  root "home#index"
  get '/summary', to: 'home#summary'
  get '/checkout', to: 'home#checkout'
end
