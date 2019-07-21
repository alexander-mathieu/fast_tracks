# frozen_string_literal: true

class User < ApplicationRecord
  has_many :user_songs
  has_many :songs, through: :user_songs
  has_many :activities

  def top_songs(limit)
    songs
      .joins(:user_songs)
      .select('songs.*, user_songs.played_at, user_songs.power_ranking')
      .order(power_ranking: :DESC)
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