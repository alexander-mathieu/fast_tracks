# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'As a user who has connected their Spotify account' do
  describe 'when I visit the dashboard path' do
    before :each do
      @user = create(:user)

      create(:user_song, user: @user, song: create(:song, spotify_id: '2MIcpZ7MBeCUEVFDBqU7Ei'))
      create(:user_song, user: @user, song: create(:song, spotify_id: '4v6dF5830rtgjYr0uov248'))
      create(:user_song, user: @user, song: create(:song, spotify_id: '2SpLqYLZ5GQTFTDwA4xwGS'))
      create(:user_song, user: @user, song: create(:song, spotify_id: '5fUZNS9QZXOg0aYjnIjr1H'))
      create(:user_song, user: @user, song: create(:song, spotify_id: '0tuE3l1TPJ9tKG4w63kgtf'))

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      VCR.use_cassette 'recommended_get_recommendations' do
        visit dashboard_path
      end
    end

    it 'I see power rankings associated with each song on my dashboard' do
      within '.top-songs' do
        within(first('.song')) do
          expect(page).to have_css('.song-power-index')
          expect(page).to have_content(10)
        end
      end
    end
  end
end
