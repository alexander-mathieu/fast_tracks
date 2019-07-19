# frozen_string_literal: true

FactoryBot.define do
  factory :song do
    spotify_id { 'MyString' }
    title { 'MyString' }
    artist { 'MyString' }
    album { 'MyString' }
    spotify_url { 'MyString' }
    album_art_url { 'MyString' }
    length { 1 }
  end
end
