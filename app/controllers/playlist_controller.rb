# frozen_string_literal: true

class PlaylistController < ApplicationController
  def create
    playlist = add_playlist(current_user.spotify_uid, params[:playlist_name])
    spotify_service.add_songs_to_playlist(playlist[:id], params[:song_uris])
    flash[:success] = 'Playlist successfully added!'
    redirect_to dashboard_path
  end

  private

  def add_playlist(spotify_user_id, playlist_name)
    spotify_service.create_user_playlist(spotify_user_id, playlist_name)
  end

  def spotify_service
    @spotify_service ||= SpotifyService.new(current_user.spotify_token)
  end
end
