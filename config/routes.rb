Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  root to: 'home#index'

  resources :password_resets, only: [:new, :create]  # Sem o 'edit'

  # Rota personalizada para o 'edit' que usa o 'token'
  get 'password_resets/:token/edit', to: 'password_resets#edit', as: 'edit_password_reset'
  patch 'password_resets/:token', to: 'password_resets#update', as: 'password_reset'
  
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :passwords_set, only: [:new, :create]

  get 'passwords_set/:token/edit', to: 'passwords_set#edit', as: 'edit_passwords_set'
  patch 'passwords_set/:token', to: 'passwords_set#update', as: 'passwords_set'

  
  
  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
