Rails.application.routes.draw do
  root "static_pages#index"
  devise_for :users, controllers: { registrations: 'registrations', sessions: 'sessions', omniauth_callbacks: 'callbacks' }
  resources :users
end
