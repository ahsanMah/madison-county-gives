Rails.application.routes.draw do
  devise_for :users
  resources :organizations, except: :destroy
  #resources :campaigns, only: [:index, :show]
  root "home#index"
  resource :campaigns
end
