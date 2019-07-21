# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'As a user who has connected their Spotify account' do
  describe 'when I visit the dashboard path' do
    before(:each) do
      @user = create(:user)
      create(:user_song, user: @user, power_ranking: 0.9, song: create(:song, spotify_id: '2MIcpZ7MBeCUEVFDBqU7Ei'))
      create(:user_song, user: @user, power_ranking: 0.8, song: create(:song, spotify_id: '4v6dF5830rtgjYr0uov248'))
      create(:user_song, user: @user, power_ranking: 0.7, song: create(:song, spotify_id: '2SpLqYLZ5GQTFTDwA4xwGS'))
      create(:user_song, user: @user, power_ranking: 0.6, song: create(:song, spotify_id: '5fUZNS9QZXOg0aYjnIjr1H'))
      create(:user_song, user: @user, power_ranking: 0.5, song: create(:song, spotify_id: '0tuE3l1TPJ9tKG4w63kgtf'))
      create(:user_song, user: @user, song: create(:song))
      create(:user_song, user: @user, song: create(:song))
      create(:user_song, user: @user, song: create(:song))
      create(:user_song, user: @user, song: create(:song))
      create(:user_song, user: @user, song: create(:song))
      create(:user_song, user: @user, song: create(:song))

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end
    it 'I see a list of 10 songs ' do
      VCR.use_cassette 'recommended_get_recommendations' do
        visit dashboard_path
      end
      
      expect(page).to have_content(@user.strava_firstname)

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