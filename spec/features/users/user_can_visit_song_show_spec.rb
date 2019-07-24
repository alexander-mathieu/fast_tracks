# frozen_string_literal: true

require 'rails_helper'

describe 'As a fully connected user' do
  describe 'I visit a song show page' do
    before :each do
      @sp_token = 'fake_token'
      @st_token = 'fake_token'
      @song = create(:song)
      @user = create(:user, spotify_token: @sp_token, strava_token: @st_token)
      @user_song = create(:user_song, user_id: @user.id, song_id: @song.id)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it 'Takes me to a show page with a title and album cover' do
      visit song_path(@song)

      within '#song-title' do
        expect(page).to have_content(@song.title)
      end

      expect(page).to have_selector('#album-art')
    end

    it 'Has a chart with all of the previous times I have listened to the song and the PR' do
      visit song_path(@song)

      within('#pr-chart') do
        expect(page).to have_content('PowerRanking Over Time')
        expect(page).to have_css('#chart-0')
      end
    end

    it 'has all of the information on that song' do
      visit song_path(@song)

      seconds = (@song.length / 1000.0)

      within '#song-info' do
        expect(page).to have_content(@song.artist)
        expect(page).to have_content(@song.album)
        expect(page).to have_content("#{(seconds / 60).floor.to_s}:#{(seconds % 60) .floor.to_s.rjust(2, '0')}")
        expect(page).to have_link('Listen on Spotify', href: @song.spotify_url)
      end
    end

    it 'displays the average PowerRanking for that song' do
      create(:user_song, user_id: @user.id, song_id: @song.id, power_ranking: 1.0)
      create(:user_song, user_id: @user.id, song_id: @song.id, power_ranking: 0.75)

      visit song_path(@song)

      within '#song-metrics' do
        expect(page).to have_content('Average PowerRanking: 75')
      end
    end
  end
end
