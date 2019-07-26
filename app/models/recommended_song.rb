# frozen_string_literal: true

# Top Level Class Documentation
class RecommendedSong
  attr_reader :spotify_id

  def initialize(data)
    @spotify_id = data[:spotify_id]
  end

  def spotify_uri
    'spotify:track:' + spotify_id
  end
end
