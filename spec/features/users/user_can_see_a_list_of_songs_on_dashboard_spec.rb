# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'As a user who has connected their Spotify account' do
  describe 'when I visit the dashboard path' do
    before(:each) do
      @user = User.create!(strava_uid: 123,
                          strava_firstname: 'Homer',
                          strava_lastname: 'Simpson',
                          strava_token: '12345abcde',
                          spotify_token: 'abcde12345',
                          spotify_uid: 'string_token')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end
    it "I see a list of 10 songs " do
      visit dashboard_path
      
      expect(page).to have_content(@user.strava_firstname)

      within '.top-songs' do
        within first(".song") do
          expect(page).to have_css('.song-rank')
          expect(page).to have_css('.song-title a')
          expect(page).to have_css('.song-play-count')
          expect(page).to have_css('.song-last-played')
          expect(page).to have_css('.song-power-index')
        end
      end
    end
  end
end