class RecommendedSong
  attr_reader :spotify_id

  def initialize(data)
    @spotify_id = data[:spotify_id]
  end
end
