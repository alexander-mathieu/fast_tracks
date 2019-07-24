# frozen_string_literal: true

require 'rails_helper'

describe SpotifyService do
  before :each do
    @spotify_service = SpotifyService.new('spotify_token')
  end

  describe 'instance methods' do
    before :all do
      VCR.turn_off!
    end

    after :all do
      VCR.turn_on!
    end

    it '#get_user_songs' do
      stub_data = File.read('./spec/fixtures/spotify_user_songs.json')

      stub_request(:get, 'https://api.spotify.com/v1/me/player/recently-played?limit=50')
        .to_return(status: 200, body: stub_data)

      user_songs = @spotify_service.get_user_songs

      expect(user_songs).to be_a Hash
      expect(user_songs[:items]).to be_an Array
      expect(user_songs[:items].first[:track]).to have_key :id
      expect(user_songs[:items].first[:track]).to have_key :name
      expect(user_songs[:items].first[:track]).to have_key :external_urls
    end

    it '#get_user_info' do
      stub_data = File.read('./spec/fixtures/spotify_user_info.json')

      stub_request(:get, 'https://api.spotify.com/v1/me')
        .to_return(status: 200, body: stub_data)

      user_info = @spotify_service.get_user_info

      expect(user_info).to be_a Hash
      expect(user_info[:display_name]).to eq 'rwkoa'
    end

    it '#find_user_playlists' do
      stub_data = File.read('./spec/fixtures/spotify_user_playlists.json')

      stub_request(:get, 'https://api.spotify.com/v1/me/playlists')
        .to_return(status: 200, body: stub_data)

      user_playlists = @spotify_service.find_user_playlists

      expect(user_playlists).to be_an Array
      expect(user_playlists.first).to be_a Hash
      expect(user_playlists.first).to have_key :id
      expect(user_playlists.first).to have_key :name
    end

    it '#create_user_playlist' do
      stub_data = File.read('./spec/fixtures/spotify_create_playlist.json')

      stub_request(:post, 'https://api.spotify.com/v1/users/rwkoa/playlists')
        .with(
          body: "{\"name\":\"new playlist who dis\", \"public\":true}",
          headers: {
                   	'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                   	'Content-Type' => 'application/json'
                   })
        .to_return(status: 200, body: stub_data)

      new_playlist = @spotify_service.create_user_playlist('rwkoa', 'new playlist who dis')

      expect(new_playlist).to be_a Hash
      expect(new_playlist).to have_key :id
      expect(new_playlist).to have_key :name
    end

    it '#add_songs_to_playlist' do
      stub_data = File.read('./spec/fixtures/spotify_add_playlist_songs.json')
      track_uris = 'spotify:track:2MIcpZ7MBeCUEVFDBqU7Ei,spotify:track:4v6dF5830rtgjYr0uov248,spotify:track:2SpLqYLZ5GQTFTDwA4xwGS,spotify:track:5fUZNS9QZXOg0aYjnIjr1H,spotify:track:0tuE3l1TPJ9tKG4w63kgtf'

      stub_request(:post, "https://api.spotify.com/v1/playlists/5q5Wi8USpqUBwBa7MMb6MH/tracks?uris=#{track_uris}")
        .to_return(status: 200, body: stub_data)

      new_tracks = @spotify_service.add_songs_to_playlist('5q5Wi8USpqUBwBa7MMb6MH', track_uris)

      expect(new_tracks).to be_a Hash
      expect(new_tracks).to have_key :snapshot_id
    end
  end
end
