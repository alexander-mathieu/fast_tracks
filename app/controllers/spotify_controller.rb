# frozen_string_literal: true

# controller for Spotify oauth sessions
class SpotifyController < ApplicationController
  def create
    token_info = SpotifyOauthGenerator.new(params['code']).connect_to_spotify
    current_user.spotify_token = token_info['refresh_token']
    current_user.save
    redirect_to root_path
  end
end
