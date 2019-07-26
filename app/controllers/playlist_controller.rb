# frozen_string_literal: true

class PlaylistController < ApplicationController
  def create
    if playlists_include_fasttracks?
      playlist = fasttracks_playlist
    else
      playlist = create_fasttracks_playlist(current_user.spotify_uid)
    end
    spotify_service.add_songs_to_playlist(playlist[:id], params[:song_uris])
    flash[:success] = 'Successfully added!'
    redirect_to dashboard_path
  end

  private

  def create_fasttracks_playlist(spotify_user_id)
    spotify_service.create_fasttracks_playlist(spotify_user_id)
  end

  def fasttracks_playlist
    playlists = find_playlists
    playlists.find { |playlist| playlist[:name] == 'FastTracks' }
  end

  def playlists_include_fasttracks?
    playlists = find_playlists
    playlists.any? { |playlist| playlist[:name] == 'FastTracks' }
  end

  def find_playlists
    @find_playlists ||= spotify_service.find_user_playlists
  end

  def spotify_service
    @spotify_service ||= SpotifyService.new(current_user.spotify_token)
  end
end
