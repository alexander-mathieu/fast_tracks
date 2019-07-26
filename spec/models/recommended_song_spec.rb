# frozen_string_literal: true

require 'spec_helper'
require './app/models/recommended_song'

RSpec.describe RecommendedSong, type: :model do
  before :each do
    data = {
      album: 'FML',
      album_art_url: 'https://i.scdn.co/image/f4df5c3409bb23c7170639a0132849c600594e24',
      artist: 'K.Flay',
      length: 207724,
      spotify_id: '6kbCH9kQoNzaEt1R1rizpR',
      spotify_url: 'https://open.spotify.com/track/6kbCH9kQoNzaEt1R1rizpR',
      title: 'FML'
    }

    @song = RecommendedSong.new(data)
  end

  describe 'attributes' do
    it 'has a spotify_id' do
      expect(@song.spotify_id).to eq('6kbCH9kQoNzaEt1R1rizpR')
    end

    it 'has a spotify_uri' do
      expect(@song.spotify_uri).to eq('spotify:track:6kbCH9kQoNzaEt1R1rizpR')
    end

    it 'does not have a name or artist' do
      expect(@song).to_not respond_to('.name')
      expect(@song).to_not respond_to('.artist')
    end
  end
end
