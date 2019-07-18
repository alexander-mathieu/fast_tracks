class SpotifyController < ApplicationController
  def create
 	client_id     = ENV['SPOTIFY_CLIENT_ID'] 
  	client_secret = ENV['SPOTIFY_CLIENT_SECRET']  
  	code          = params[:code]
	redirect_uri 	= "http://localhost:3000/auth/spotify/callback"
  	response      = Faraday.post("https://accounts.spotify.com/api/token?grant_type=authorization_code&client_id=#{client_id}&client_secret=#{client_secret}&code=#{code}&redirect_uri=#{redirect_uri}")
	redirect_to root_path
  end
end
