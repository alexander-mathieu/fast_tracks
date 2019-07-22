# frozen_string_literal: true

class User < ApplicationRecord
  has_many :user_songs
  has_many :songs, through: :user_songs
  has_many :activities

  def top_songs(limit)
    songs
    .select("songs.*, MAX(user_songs.played_at) AS last_played_at, AVG(user_songs.power_ranking) AS avg_power_ranking, COUNT(user_songs.played_at) AS play_count")
      .where("power_ranking > 0")
      .group("songs.id")
      .order("avg_power_ranking DESC")
      .limit(limit)
  end

  def last_activity_id
    activities
      .order(strava_id: :DESC)
      .pluck(:strava_id)
      .first
  end

  def play_count(song)
    user_songs
      .where(song_id: song.id)
      .size
  end
end