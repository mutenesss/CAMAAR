Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  root to: 'home#index'

  resources :password_resets, only: [:new, :create, :update]  # Sem o 'edit'

  # Rota personalizada para o 'edit' que usa o 'token'
  get 'password_resets/:token/edit', to: 'password_resets#edit', as: 'edit_password_reset'
  
  resources :gerenciamento do
    collection do
      get 'new_form'
      post 'create_form'
    end
  end
  resources :avaliacoes
  resources :templates
  resources :respostas 

  #get "/gerenciamento", to: "gerenciamento#index"
  #get "/importar_dados", to: "gerenciamento#importar_dados"
  #get "/ver_templates", to: "gerenciamento#ver_templates"
  #get "/ver_respostas", to: "gerenciamento#ver_respostas"
  #get "/criar_formulario", to: "gerenciamento#criar_formulario"
  
  get "/avaliacoes", to: "avaliacoes#index"
  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
