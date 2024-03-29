# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'As a registered user' do
  describe 'when I visit my dashboard' do
    before :each do
      @user = create(:user, spotify_uid: '12345', spotify_token: '67890abcde')

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

    it 'I see a button to add each recommended song to my FastTracks playlist' do
      within '.recommended-songs' do
        within first '.recommended-song' do
          expect(page).to have_button 'Add'
        end
      end
    end

    it 'I see a button to add all recommended songs to my FastTracks playlist' do
      within '.recommended-songs' do
        expect(page).to have_button 'Add All'
      end
    end

    describe 'and click the button to add a song to my FastTracks playlist' do
      it 'I see a success message' do
        VCR.use_cassette 'add_song_to_fasttracks_playlist' do
          within '.recommended-songs' do
            within first '.recommended-song' do
              click_button 'Add'
            end
          end
        end

        expect(current_path).to eq(dashboard_path)
        expect(page).to have_content('Successfully added!')
      end
    end

    describe 'and click the button to add all songs to my FastTracks playlist' do
      it 'I see a success message' do
        VCR.use_cassette 'add_all_songs_to_fasttracks_playlist' do
          within '.recommended-songs' do
            click_button 'Add All'
          end
        end

        expect(current_path).to eq(dashboard_path)
        expect(page).to have_content('Successfully added!')
      end
    end
  end
end
