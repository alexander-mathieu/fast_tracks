# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'when I visit the root path' do
    it "I see a button to 'Login with Strava'" do
      visit root_path

      expect(page).to have_button('Login with Strava')
    end

    describe "and I click the button to 'Login with Strava'" do
      it 'I complete the Strava OAuth process and redirect to my dashboard' do
        OmniAuth.config.test_mode = true

        OmniAuth.config.mock_auth[:strava] = OmniAuth::AuthHash.new(
          provider: 'strava',
          credentials: { token: ENV['STRAVA_TEST_TOKEN'] })

        user = User.create!(strava_uid: 3214,
                            strava_firstname: 'William',
                            strava_lastname: 'Homer',
                            strava_token: ENV['STRAVA_TEST_TOKEN'])

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit root_path
        click_button 'Login with Strava'

        expect(current_path).to eq(dashboard_path)
        expect(page).to have_content(user.strava_firstname)
      end
    end
  end
end
