# frozen_string_literal: true

Rails.application.routes.draw do
  root 'welcome#index'

  get '/dashboard', to: 'users#show'
  resources :songs, only: [:show]
  resources :stravas, only: [:create]

  get 'auth/strava/callback', to: 'login#create'
  get 'auth/spotify/callback', to: 'spotify#create'
  get 'spotify/songs', to: 'spotify#index'
  post '/playlist', to: 'playlist#create'

  post 'hooks/strava', to: 'hooks#strava'
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
