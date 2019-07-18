Rails.application.routes.draw do
  root 'welcome#index'

  get '/dashboard', to: 'users#show'

  get 'auth/strava/callback', to: 'login#new'
end
