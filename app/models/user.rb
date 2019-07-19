# frozen_string_literal: true

class User < ApplicationRecord
  has_many :user_songs
  has_many :songs, through: :user_songs

  def top_songs(limit)
    songs
      .joins(:user_songs)
      .select("songs.*, user_songs.play_count, user_songs.power_ranking")
      .order(power_ranking: :DESC)
      .limit(limit)
  end
end