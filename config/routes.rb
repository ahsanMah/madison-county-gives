Rails.application.routes.draw do
  devise_for :users
  resources :organizations, except: :destroy
  resources :campaigns #, only: [:index, :show, :new, :create]
  resources :campaign_changes
  get 'campaign_changes/approve/:id', to: "campaigns_change#approve"
  
  root "campaigns#index"
  get '/summary', to: 'home#summary'
  get '/checkout', to: 'home#checkout'
end
