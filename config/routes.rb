Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  namespace :api do
    namespace :v1 do
      resources :characters, only: [:show, :create]
      resources :campaigns, only: [:show, :create, :update] do
        post :advance_week
      end
      resources :items, only: [:index, :show]
      resources :management_forms, only: [:update]
      resources :campaign_items, only: [:create, :update]
      resources :users, only: [:show] do
        resources :user_campaigns, only: [:index]
      end
      resources :user_campaigns, only: [:create, :update]
      get '/management_form', to: 'management_forms#show'
      get '/campaigns/:id/characters', to: 'campaigns/characters#index'
      get '/campaigns/:id/items', to: 'campaigns/items#index'
    end
  end
end
