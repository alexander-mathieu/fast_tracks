# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'As a user who has connected their Spotify account' do
  describe 'when I visit the dashboard path' do
    before(:each) do
      @user = create(:user, strava_token: ENV['STRAVA_TEST_TOKEN'])
      activity_1 = create(:activity, user_id: @user.id)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end
    it 'I should see a button to sync strava data' do
      visit dashboard_path

      expect(page).to have_button('Sync My Strava Data')

      VCR.use_cassette('strava_user_activities') do
        click_on 'Sync My Strava Data'
      end

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content('Strava data synced')
    end
  end
end