Rails.application.routes.draw do
  root 'welcome#index'

  get '/dashboard', to: 'users#show'
  resources :songs, only: [:show]

  get 'auth/strava/callback', to: 'login#create'
end
