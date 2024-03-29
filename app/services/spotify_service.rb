# frozen_string_literal: true

# service for getting spotify user songs
class SpotifyService
  def initialize(user_token)
    @user_token = user_token
  end

  def get_user_songs
    params = { limit: 50 }
    url = '/v1/me/player/recently-played'
    get_json(url, params)
  end

  def get_user_info
    get_json('/v1/me')
  end

  def find_user_playlists
    get_json('https://api.spotify.com/v1/me/playlists')[:items]
  end

  def create_fasttracks_playlist(spotify_user_id)
    post_playlist("/v1/users/#{spotify_user_id}/playlists", "{\"name\":\"FastTracks\", \"public\":true}")
  end

  def add_songs_to_playlist(playlist_id, song_uris)
    post_songs("/v1/playlists/#{playlist_id}/tracks?uris=#{song_uris}")
  end

  private

  def post_songs(url)
    response = conn.post(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def post_playlist(url, params = {})
    response = conn.post do |req|
      req.url url
      req.headers['Content-Type'] = 'application/json'
      req.body = params
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def get_json(url, params = {})
    response = conn.get(url, params)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new('https://api.spotify.com') do |faraday|
      faraday.adapter Faraday.default_adapter
      faraday.headers['Authorization'] = 'Bearer ' + @user_token
    end
  end
end
