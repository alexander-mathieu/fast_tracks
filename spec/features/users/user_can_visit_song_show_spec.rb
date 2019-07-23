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
      allow_any_instance_of(ApplicationController).to \
      receive(:current_user).and_return(@user)
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
        expect(page).to have_content("PowerRanking Over Time")
        expect(page).to have_css('#chart-0')
      end
    end
  end
end
