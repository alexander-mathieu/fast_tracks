# frozen_string_literal: true

class User < ApplicationRecord
  has_many :user_songs
  has_many :songs, through: :user_songs
end