require 'sidekiq/web'

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'sections#index'

  resources :sections, format: false
  post '/sections/:id/scan', as: 'scan_section', to: 'sections#scan', format: false

  resources :usages, format: false

  mount Sidekiq::Web => '/sidekiq'
  # authenticate :user, ->(user) { user.admin? } do
  #   mount Sidekiq::Web => '/sidekiq'
  # end
end
