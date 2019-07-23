# frozen_string_literal: true

require 'rails_helper'

describe SongSifter, type: :model do
  before :each do
    VCR.use_cassette('spotify_song_sifter', allow_playback_repeats: true) do
      token = 'BQBniXrHZ-oEVfQq2vPJvFn6qg_Ugfntv1my6xfUA6VAq_cXCOzK4DISDouOZTcG9l1Y-Tce2QDpXS594evWwMZscQTGw6j5n3Eo-pXyQ8SD-P5IhLKZcuasnewiridkblgatGiia9M23s6aLY_J5QFGJA'
      @user = create(:user, spotify_token: token)
      service = SpotifyService.new(token)
      @songs_data = service.get_user_songs[:items]
      @song_sifter = SongSifter.new(@songs_data, @user)
      @attrs = { title: 'title', artist: 'artist', album: 'album',
                 album_art_url: 'url', spotify_url: 'url',
                 spotify_id: 'spotify_id', length: 8_675_309,
                 played_at: DateTime.parse('2016-12-13T20:44:04.589Z') }
    end
  end

  it 'can grab attributes from song hash' do
    VCR.use_cassette('spotify_song_sifter', allow_playback_repeats: true) do
      actual = @song_sifter.attr_grabber(@songs_data.first)
      expect(actual).to be_a(Array)
      expect(actual.count).to eq(8)
      expect(actual.first).to be_a(String)
      expect(actual.third).to eq('No Diablo')
    end
  end

  it 'can take attr_grab_arry and make attr_hash' do
    VCR.use_cassette('spotify_song_sifter', allow_playback_repeats: true) do
      attr_grab_arry = @song_sifter.attr_grabber(@songs_data.first)
      actual = @song_sifter.attr_hasher(attr_grab_arry)

      expect(actual.keys.count).to eq(8)
      expect(actual[:title]).to eq('No Diablo')
    end
  end

  it 'Can take an attributes hash and build a song' do
    VCR.use_cassette('spotify_song_sifter', allow_playback_repeats: true) do
      @song_sifter.song_build(@attrs)
      actual = Song.last

      expect(actual.title).to eq(@attrs[:title])
      expect(actual.artist).to eq(@attrs[:artist])
      expect(actual.album).to eq(@attrs[:album])
      expect(actual.album_art_url).to eq(@attrs[:album_art_url])
      expect(actual.spotify_url).to eq(@attrs[:spotify_url])
      expect(actual.length).to eq(@attrs[:length])
    end
  end

  it 'Can take attributes and build a user_song' do
    VCR.use_cassette('spotify_song_sifter', allow_playback_repeats: true) do
      @song_sifter.song_build(@attrs)
      song = Song.last
      @song_sifter.user_song_build(song.id, @attrs[:played_at])
      actual = UserSong.last

      expect(actual).to be_a(UserSong)
      expect(actual.played_at).to eq(@attrs[:played_at])
      expect(actual.user_id).to eq(@user.id)
      expect(actual.song_id).to eq(song.id)
    end
  end

  it 'wont duplicate songs or user songs' do
    VCR.use_cassette('spotify_song_sifter', allow_playback_repeats: true) do
      @song_sifter.song_build(@attrs)
      @song_sifter.song_build(@attrs)
      expect(Song.all.count).to eq(1)
      song = Song.last

      @song_sifter.user_song_build(song.id, @attrs[:played_at])
      @song_sifter.user_song_build(song.id, @attrs[:played_at])
      expect(UserSong.all.count).to eq(1)
    end
  end
end
