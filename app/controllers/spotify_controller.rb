# frozen_string_literal: true

# controller for Spotify oauth sessions
class SpotifyController < ApplicationController
  def create
    token_info = SpotifyOauthGenerator.new(params['code']).connect_to_spotify
    current_user.spotify_token = token_info['access_token']
    current_user.spotify_uid = user_info[:id]
    current_user.save
    flash[:success] = 'Connected to Spotify!'
    redirect_to dashboard_path
  end

  def index
    SongSyncJob.perform_later(current_user)
    flash[:success] = 'Spotify data synced!'
    redirect_to dashboard_path
  end

  private

  def user_info
    spotify_service.get_user_info
  end

  def spotify_service
    @spotify_service ||= SpotifyService.new(current_user.spotify_token)
  end
end
