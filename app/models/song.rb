# frozen_string_literal: true

class Song < ApplicationRecord
  has_many :user_songs
  has_many :users, through: :user_songs
end
