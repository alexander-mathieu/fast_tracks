# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'As a registered user' do
  describe 'when I visit my dashboard' do
    before :each do
      @user = create(:user, spotify_uid: '123456', spotify_token: '123456abcde')

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

      VCR.use_cassette 'recommended_get_recommendations' do
        visit dashboard_path
      end
    end

    it 'I see a form to create a playlist on Spotify using recommended songs' do
      within '.recommended-songs' do
        within '.playlist-export' do
          expect(page).to have_field :playlist_name
          expect(page).to have_button 'Create Playlist'
        end
      end
    end

    describe 'and fill out the form to export a playlist to Spotify correctly' do
      it 'I stay on my current path and see a message telling me the playlist was added' do
        fill_in :playlist_name, with: 'New Jams'

        VCR.use_cassette 'export_spotify_playlist' do
          click_button 'Create Playlist'
        end

        expect(current_path).to eq(dashboard_path)
        expect(page).to have_content('Playlist successfully added!')
      end
    end
  end
end
