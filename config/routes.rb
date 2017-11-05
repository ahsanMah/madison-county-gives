Rails.application.routes.draw do
  devise_for :users
  resources :organization, except: :destroy
  resources :campaign, only: [:index, :show]
  root "home#index"
  resource :campaigns
  get '/summary', to: 'home#summary'
  get '/checkout', to: 'home#checkout'
end
