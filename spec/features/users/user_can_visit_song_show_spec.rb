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
      expect(page).to have_selector('#song-metrics')
      expect(page).to have_selector('#last-activities')
    end
  end
end
