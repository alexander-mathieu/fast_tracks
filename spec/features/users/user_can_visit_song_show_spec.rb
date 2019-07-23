# frozen_string_literal: true

require 'rails_helper'

describe 'As a fully connected user on my dashboard path' do
  describe 'I click a song link' do
    it 'Takes me to a show page with title, metrics, album cover, and 5 activities' do
      sp_token = 'fake_token'
      st_token = 'fake_token'
      song = create(:song)
      user = create(:user, spotify_token: sp_token, strava_token: st_token)
      user_song = create(:user_song, user_id: user.id, song_id: song.id)
      allow_any_instance_of(ApplicationController).to \
        receive(:current_user).and_return(user)

      visit dashboard_path
      click_link(song.title)
      expect(current_path).to eq(song_path(song))

      within '#song-title' do
        expect(page).to have_content(song.title)
      end

      expect(page).to have_selector('#album-art')
      expect(page).to have_selector('#song-metrics')
      expect(page).to have_selector('#last-activities')
    end
  end
end
