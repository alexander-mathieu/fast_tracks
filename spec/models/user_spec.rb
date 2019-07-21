# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:songs) }
  it { should have_many(:activities) }

  it '.top_songs by limit' do
    user = create(:user)
    song_1 = create(:song)
    song_2 = create(:song)
    song_3 = create(:song)
    user_song_1 = create(:user_song, user: user, song: song_1, power_ranking: 7)
    user_song_2 = create(:user_song, user: user, song: song_2)
    user_song_3 = create(:user_song, user: user, song: song_3)

    results = user.top_songs(1)
    result = user.top_songs(1).first

    expect(results.length).to eq(1)
    expect(result.id).to eq(song_1.id)
    expect(result.spotify_id).to eq(song_1.spotify_id)
    expect(result.title).to eq(song_1.title)
    expect(result.artist).to eq(song_1.artist)
    expect(result.album).to eq(song_1.album)
    expect(result.spotify_url).to eq(song_1.spotify_url)
    expect(result.album_art_url).to eq(song_1.album_art_url)
    expect(result.length).to eq(song_1.length)
    expect(result.played_at).to eq(user_song_1.played_at)
    expect(result.power_ranking).to eq(user_song_1.power_ranking)
  end

  it '.last_activity_id' do
    user = create(:user)
    activity_1 = create(:activity, strava_id: 123123, user_id: user.id)
    activity_2 = create(:activity, strava_id: 123121, user_id: user.id)

    expect(user.last_activity_id).to eq(activity_1.strava_id)
  end

  it '.play_count' do
    user = create(:user)
    song_1 = create(:song)
    user_song_1 = create(:user_song, user: user, song: song_1, power_ranking: 7)
    user_song_2 = create(:user_song, user: user, song: song_1)
    user_song_3 = create(:user_song, user: user, song: song_1)

    expect(user.play_count(song_1)).to eq(3)
  end
end
