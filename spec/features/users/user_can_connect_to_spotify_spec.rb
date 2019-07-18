require 'rails_helper'

feature "as a logged in user on my dashboard" do
	before :each do 
		@user = User.create!(strava_firstname: "bob", strava_lastname: "ross", strava_token: ENV['STRAVA_TEST_TOKEN'])	
		allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)		
	end

	scenario "I see a button to connect to spotify" do
		visit dashboard_path
		expect(page).to have_button("Connect to Spotify")		
	end
end
