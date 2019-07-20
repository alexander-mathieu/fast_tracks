# frozen_string_literal: true

class DashboardShowFacade
  attr_reader :top_songs

  def initialize(current_user)
    @top_songs = current_user.top_songs(10)
  end

  def build_link
    link = 'https://accounts.spotify.com/authorize?'
    client_pair = "client_id=#{ENV['SPOTIFY_CLIENT_ID']}&"
    code_pair = 'response_type=code&'
    redirect_pair = 'redirect_uri=http://localhost:3000/auth/spotify/callback'
    link + client_pair + code_pair + redirect_pair
  end
end
