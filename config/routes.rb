require 'sidekiq/web'
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'sections#index'
  devise_for :users, path: '', path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      password: 'secret',
      confirmation: 'verification',
      unlock: 'unblock',
      registration: 'register',
      sign_up: 'cmon_let_me_in'
  }, :controllers => { :omniauth_callbacks => "callbacks" }

  resources :sections, format: false
  post '/sections/:id/scan', as: 'scan_section', to: 'sections#scan', format: false
  post '/sections/:id/export', as: 'export_section', to: 'sections#export', format: false

  resources :usages, format: false
  post '/usages/:id/scan', as: 'scan_usage', to: 'usages#scan', format: false

  authenticate :user do
    mount Sidekiq::Web => '/sidekiq'
  end
end
