# frozen_string_literal: true

require 'rails_helper'

describe 'as a user on the dashboard path' do
  describe 'if I do not have a spotify token' do
    it 'displays username and link styled as a button to connect to spotify' do
      user = create(:user, spotify_token: nil, spotify_uid: nil)
			name = user.strava_firstname + " " + user.strava_lastname
      allow_any_instance_of(ApplicationController).to \
        receive(:current_user).and_return(user)
      visit dashboard_path

      expect(page).to have_selector('#spot-conn-link')
      expect(page).to have_link('Connect to Spotify')
			expect(page).to have_content(name)
    end
  end

  describe 'if I do have a token' do
    it 'does not display the link' do
      user = create(:user, spotify_token: 8_675_309, spotify_uid: nil)
			name = user.strava_firstname + " " + user.strava_lastname
      allow_any_instance_of(ApplicationController).to \
        receive(:current_user).and_return(user)
      visit dashboard_path

      expect(page).to_not have_selector('#spot-conn-link')
      expect(page).to_not have_link('Connect to Spotify')
			expect(page).to have_content(name)
    end
  end
end
