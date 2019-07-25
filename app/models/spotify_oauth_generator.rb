# frozen_string_literal: true

# Handrolled Spotify Oauth poro for post request with code
class SpotifyOauthGenerator
  def initialize(code)
    @code = code
    @redirect_uri = 'https://rocky-springs-29283.herokuapp.com/auth/spotify/callback'
    @conn = Faraday.new('https://accounts.spotify.com/') do |faraday|
      faraday.adapter Faraday.default_adapter
    end
  end

  def connect_to_spotify
    response = @conn.post('/api/token') do |req|
      req.params['grant_type'] = 'authorization_code'
      req.params['client_id'] = ENV['SPOTIFY_CLIENT_ID']
      req.params['client_secret'] = ENV['SPOTIFY_CLIENT_SECRET']
      req.params['code'] = @code
      req.params['redirect_uri'] = @redirect_uri
    end
    JSON.parse(response.body)
  end
end
