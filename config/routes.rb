require 'sidekiq/web'
require 'sidekiq-scheduler/web'

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
  }, :controllers => { :omniauth_callbacks => "callbacks" }

  resources :sections, format: false do
    post 'scan', as: 'scan', to: 'sections#scan', format: false
    post 'export', as: 'export', to: 'sections#export', format: false

    resources :usages, format: false do
      post 'scan', as: 'scan', to: 'usages#scan', format: false
    end
  end



  mount API::Base, at: '/'
  mount GrapeSwaggerRails::Engine => '/docs'

  authenticate :user, lambda { |u| u.admin? } do
    namespace :admin do
      resources :users
      resources :permissions, except: [:show]
    end

    mount Sidekiq::Web => '/sidekiq'
  end
end
