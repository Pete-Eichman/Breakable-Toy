Rails.application.routes.draw do
  root "homepage#index"
  devise_for :users, controllers: { registrations: 'registrations', sessions: 'sessions', omniauth_callbacks: 'callbacks' }
  resources :users
  resources :parking_passes do
    resources :bookings
  end
  post "bookings/incoming", to: 'booking#accept_or_reject', as: 'incoming'
  resources :maps
end
