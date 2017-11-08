Rails.application.routes.draw do
  devise_for :users
  resources :organizations, except: :destroy
  resources :campaigns #, only: [:index, :show, :new, :create]
  resources :campaign_changes
  get 'campaign_changes/approve/:id', to: "campaign_changes#approve", as: :approve_campaign_change

  root "campaigns#index"
  get '/summary', to: 'home#summary'
  get '/checkout', to: 'home#checkout'
end
