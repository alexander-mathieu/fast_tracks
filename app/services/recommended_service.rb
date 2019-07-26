# frozen_string_literal: true

class RecommendedService
  def get_recommendations(songs)
    params = { song_ids: songs, limit: 5 }
    get_json('recommended', params)
  end

  private

  def get_json(url, params = {})
    response = conn.get(url, params)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new('https://fast-tracks-flask.herokuapp.com/api/v1/')
  end
end
