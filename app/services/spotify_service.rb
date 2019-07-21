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

  private

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
