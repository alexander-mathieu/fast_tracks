# frozen_string_literal: true

class PlaylistController < ApplicationController
  def create
    if playlists_include_new_playlist?
      playlist = build_playlist(params[:playlist_name])
    else
      playlist = create_playlist(current_user.spotify_uid, params[:playlist_name])
    end
    spotify_service.add_songs_to_playlist(playlist[:id], params[:song_uris])
    flash[:success] = 'Playlist successfully added!'
    redirect_to dashboard_path
  end

  private

  def create_playlist(spotify_user_id, playlist_name)
    spotify_service.create_user_playlist(spotify_user_id, playlist_name)
  end

  def build_playlist(playlist_name)
    playlist_object = {}
    playlists = find_playlists(current_user.spotify_uid, params[:playlist_name])
    playlist_id = playlists.find { |playlist| playlist[:name] == playlist_name }[:id]
    playlist_object[:id] = playlist_id
    playlist_object
  end

  def playlists_include_new_playlist?
    playlists = find_playlists
    playlists.any? { |playlist| playlist[:name] == params[:playlist_name] }
  end

  def find_playlists
    @find_playlists ||= spotify_service.find_user_playlists
  end

  def spotify_service
    @spotify_service ||= SpotifyService.new(current_user.spotify_token)
  end
end
