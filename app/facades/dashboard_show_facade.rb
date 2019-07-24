# frozen_string_literal: true

# Prepares data for user dashboard show view
class DashboardShowFacade
  attr_reader :top_songs

  def initialize(current_user)
    @top_songs = current_user.top_songs(10)
    @user = current_user
  end

  def spotify_song_uris
    recommended_songs.map { |song| 'spotify:track:' + song[:spotify_id] }.join(',')
  end

  def recommended_songs
    songs = @user.top_songs(5).map(&:spotify_id).join(',')
    @recommended_songs ||= recommended_service.get_recommendations(songs)
  end

  def build_link
    link = 'https://accounts.spotify.com/authorize?'
    client_pair = "client_id=#{ENV['SPOTIFY_CLIENT_ID']}&"
    code_pair = 'response_type=code&'
    redirect_pair = 'redirect_uri=http://localhost:3000/auth/spotify/callback&'
    scope_pair = 'scope=user-read-recently-played,playlist-modify-public'
    link + client_pair + code_pair + redirect_pair + scope_pair
  end

  def user_name
    @user.strava_firstname + ' ' + @user.strava_lastname
  end

  private

  def recommended_service
    @recommended_service ||= RecommendedService.new
  end
end
