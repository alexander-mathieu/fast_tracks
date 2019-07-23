# frozen_string_literal: true

# controller for Spotify oauth sessions
class SpotifyController < ApplicationController
  def create
    token_info = SpotifyOauthGenerator.new(params['code']).connect_to_spotify
    current_user.spotify_token = token_info['access_token']
    current_user.spotify_uid = params[:id]
    current_user.save
    flash[:success] = "Spotify data synced"
    redirect_to dashboard_path
  end

  def index
    songs_data = SpotifyService.new(current_user.spotify_token).get_user_songs[:items]
    SongSifter.new(songs_data, current_user).sift_songs
    redirect_to dashboard_path
  end
end
