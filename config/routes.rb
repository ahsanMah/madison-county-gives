Rails.application.routes.draw do

  # user cannot destroy account
  devise_for :users, skip: :registrations
  devise_scope :user do
    resource :registration,
      only: [:new, :create, :edit, :update],
      path: 'users',
      path_names: { new: 'sign_up' },
      controller: 'devise/registrations',
      as: :user_registration do
        get :cancel
      end
  end

  resources :organizations, except: :destroy
  resources :campaigns , only: [:index, :show]
  resources :campaign_changes
  resources :payments

  root "campaigns#index"

  get 'campaign_changes/approve/:id', to: "campaign_changes#approve", as: :approve_campaign_change
  get 'campaign_changes/delete/:id', to: "campaign_changes#delete", as: :delete_campaign_change

  get '/summary', to: 'home#summary'
  get '/checkout', to: 'home#checkout'
  post '/add_to_cart', to: 'home#add_to_cart'
  post '/processing', to: 'home#processing'
  post '/touchnet_sub', to: 'home#touchnet_sub'
  get '/remove_donation_cart', to: 'home#remove_donation_cart'

  get '/about_us', to: 'about#about_us'
  get '/faqs', to: 'about#faqs'
  get '/contact_us', to:'about#contact_us'

  mount RailsAdmin::Engine => '/data', as: 'rails_admin'
  get '/admin', to: 'admin#dashboard'
	get '/admin/campaign_approval', to: 'admin#campaign_approval'
  get '/admin/organization_approval', to: 'admin#organization_approval'
  post '/admin/create_status', to: 'admin#create_status'
end
