class SessionsController < ApplicationController
  def create
 		client_id     = "80890ce6a3434c679442d9526f2e38b8"
  	client_secret = "1fef22b83d1140b7a4fa861f0989e3b3"
  	code          = params[:code]
		redirect_uri 	= "http://localhost:3000/auth/spotify/callback"
  	response      = Faraday.post("https://accounts.spotify.com/api/token?grant_type=authorization_code&client_id=#{client_id}&client_secret=#{client_secret}&code=#{code}&redirect_uri=#{redirect_uri}")
		binding.pry
		redirect_to root_path
  end
end
