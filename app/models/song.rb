# frozen_string_literal: true

class Song < ApplicationRecord
  has_many :user_songs
  has_many :users, through: :user_songs

  def formatted_length
    length_to_seconds = (length / 1000.0)
    minutes = (length_to_seconds / 60).floor.to_s
    seconds = (length_to_seconds % 60).floor.to_s
    minutes + ':' + seconds.rjust(2, '0')
  end
end
