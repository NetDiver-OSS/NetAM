require 'sidekiq/web'
require 'sidekiq/cron/web'
require 'sidekiq-status/web'

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'application#index'

  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    password: 'secret',
    confirmation: 'verification',
    unlock: 'unblock',
    registration: 'register',
    sign_up: 'cmon_let_me_in'
  }, controllers: { omniauth_callbacks: "callbacks" }

  resources :sections, format: false do
    post 'scan', as: 'scan', to: 'sections#scan', format: false
    post 'export', as: 'export', to: 'sections#export', format: false

    post 'usages/import', as: 'import', to: 'usages#import', format: false
    resources :usages, format: false do
      post 'scan', as: 'scan', to: 'usages#scan', format: false
    end
  end

  resources :permissions, except: [:show]
  resources :api_keys, only: %i[index create destroy]

  if Rails.application.config.setup_mode
    scope path: 'setup' do
      get 'install', as: 'install', to: 'setup#install', format: false
      post 'install', as: 'new_install', to: 'setup#create', format: false
    end
  end

  mount API::Base, at: '/'

  authenticate :user, ->(u) { u.admin? } do
    namespace :admin do
      resources :users
    end

    mount GrapeSwaggerRails::Engine => '/docs'
    mount Sidekiq::Web => '/sidekiq'
  end
end
