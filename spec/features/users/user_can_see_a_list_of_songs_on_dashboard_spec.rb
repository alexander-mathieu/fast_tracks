# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'As a user who has connected their Spotify account' do
  describe 'when I visit the dashboard path' do
    before(:each) do
      @user = create(:user)
      create(:user_song, user: @user, song: create(:song))
      create(:user_song, user: @user, song: create(:song))
      create(:user_song, user: @user, song: create(:song))
      create(:user_song, user: @user, song: create(:song))
      create(:user_song, user: @user, song: create(:song))
      create(:user_song, user: @user, song: create(:song))
      create(:user_song, user: @user, song: create(:song))
      create(:user_song, user: @user, song: create(:song))
      create(:user_song, user: @user, song: create(:song))
      create(:user_song, user: @user, song: create(:song))
      create(:user_song, user: @user, song: create(:song))

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end
    it 'I see a list of 10 songs ' do
      visit dashboard_path
      
      expect(page).to have_content(@user.strava_firstname)
      save_and_open_page
      within '.top-songs' do
        expect(page).to have_selector('.song', count: 10)
        within first('.song') do
          expect(page).to have_css('.song-power-index')
          expect(page).to have_css('.song-title a')
          expect(page).to have_css('.song-artist')
          expect(page).to have_css('.song-play-count')
          expect(page).to have_css('.song-last-played')
        end
      end
    end
  end
end