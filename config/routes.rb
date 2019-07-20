# frozen_string_literal: true

Rails.application.routes.draw do
  root 'welcome#index'

  get '/dashboard', to: 'users#show'

  get 'auth/strava/callback', to: 'login#create'
  get 'auth/spotify/callback', to: 'spotify#create'
end
