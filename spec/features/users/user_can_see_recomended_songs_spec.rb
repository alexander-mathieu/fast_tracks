# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'As a user who has connected their Spotify account and' do
  describe 'when I visit the dashboard path' do
    before(:each) do
      @user = create(:user, strava_token: ENV['STRAVA_TEST_TOKEN'])
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end
    it 'display recommended songs if they have at least five songs' do
      create(:user_song, user: @user, song: create(:song, spotify_id: '2MIcpZ7MBeCUEVFDBqU7Ei'))
      create(:user_song, user: @user, song: create(:song, spotify_id: '4v6dF5830rtgjYr0uov248'))
      create(:user_song, user: @user, song: create(:song, spotify_id: '2SpLqYLZ5GQTFTDwA4xwGS'))
      create(:user_song, user: @user, song: create(:song, spotify_id: '5fUZNS9QZXOg0aYjnIjr1H'))
      create(:user_song, user: @user, song: create(:song, spotify_id: '0tuE3l1TPJ9tKG4w63kgtf'))
      
      VCR.use_cassette 'recommended_get_recommendations' do
        visit dashboard_path
      end

      expect(page).to have_content('Recommended Songs')

      within '.recommended-songs' do
        expect(page).to have_selector('.song', count: 5)
        within first('.song') do
          expect(page).to have_css('iframe')
        end
      end
    end

    it 'should not display recommendations if they have less than 5 songs' do
      visit dashboard_path

      expect(page).to have_no_content('Recommended Songs')
    end
  end
  
end