Rails.application.routes.draw do
  root "homepage#index"
  devise_for :users, controllers: { registrations: 'registrations', sessions: 'sessions', omniauth_callbacks: 'callbacks' }
  resources :users
  resources :parking_passes, only: [:index, :home, :show, :new, :create, :edit, :update, :destroy] do
    resources :bookings
  end
  resources :maps
end
