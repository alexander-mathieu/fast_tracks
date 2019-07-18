Rails.application.routes.draw do
<<<<<<< HEAD
  root 'welcome#index'

  get '/dashboard', to: 'users#show'

  get 'auth/strava/callback', to: 'login#create'
=======
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #
 
	root "home#index"
	
	get '/auth/spotify/callback', to: 'sessions#create'
>>>>>>> rs_oauth_spike
end
