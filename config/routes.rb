# frozen_string_literal: true

require 'sidekiq/web'
require 'sidekiq/cron/web'
require 'sidekiq-status/web'

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'application#index'
  mount API::Base, at: '/api'

  scope format: false do
    devise_for :users, path: '', path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      password: 'secret',
      confirmation: 'verification',
      unlock: 'unblock',
      registration: 'register',
      sign_up: ''
    }, controllers: { omniauth_callbacks: 'callbacks' }

    use_doorkeeper do
      skip_controllers :applications, :authorized_applications
    end

    resources :sections do
      post :scan
      post :export

      resources :usages do
        collection do
          post :import
        end
        post :scan
      end
    end

    resources :vlans

    namespace :account do
      resources :two_factor_auths, only: [:index, :create] do
        collection do
          post :validate
          delete :destroy
        end
      end
    end

    resources :permissions, except: [:index, :show]

    namespace :utils do
      get :calculator
    end

    if Rails.application.config.setup_mode
      namespace :setup do
        get :install
        post :create
      end
    end

    mount GrapeSwaggerRails::Engine => '/docs'

    authenticate :user, ->(u) { u.admin? } do
      namespace :admin do
        resources :backups, only: [:index, :create]
        resources :workers, except: [:show]
        resources :users

        resources :sidekiq, only: [:index]

        resources :jobs, only: [:index] do
          member do
            post :toggle
          end
        end
      end

      mount Sidekiq::Web => '/-/sidekiq'
    end
  end
end
