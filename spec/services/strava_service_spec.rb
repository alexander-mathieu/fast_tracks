# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StravaService do
  before :each do
    @strava_service = StravaService.new('123456789')
  end

  it 'exists' do
    expect(@strava_service).to be_a StravaService
  end

  describe 'instance_methods' do
    before :all do
      VCR.turn_off!
    end

    after :all do
      VCR.turn_on!
    end

    it '#get_user_info' do
      stub_data = File.read('./spec/fixtures/strava_user_info.json')

      stub_request(:get, 'https://www.strava.com/api/v3/athlete?access_token=123456789')
        .to_return(status: 200, body: stub_data)

      user_info = @strava_service.get_user_info

      expect(user_info).to be_a Hash
      expect(user_info[:id]).to be_an Integer
      expect(user_info[:firstname]).to be_a String
      expect(user_info[:lastname]).to be_a String
    end

    it '#get_user_activities' do
      stub_data = File.read('./spec/fixtures/strava_user_activities.json')

      stub_request(:get, 'https://www.strava.com/api/v3/activities?access_token=123456789')
        .to_return(status: 200, body: stub_data)

      user_activities = @strava_service.get_user_activities

      expect(user_activities).to be_an Array
      expect(user_activities.first).to be_a Hash
      expect(user_activities.first[:id]).to be_an Integer
      expect(user_activities.first[:name]).to be_a String
      expect(user_activities.first[:distance]).to be_an Float
      expect(user_activities.first[:elapsed_time]).to be_an Integer
    end

    it '#get_activity_streams' do
      stub_data = File.read('./spec/fixtures/strava_activity_streams.json')

      stub_request(:get, 'https://www.strava.com/api/v3/activities/2535456946/streams?keys=time,grade_smooth,velocity_smooth&access_token=123456789')
        .to_return(status: 200, body: stub_data)

      activity_streams = @strava_service.get_activity_streams('2535456946')

      expect(activity_streams).to be_an Array
      expect(activity_streams.first).to be_a Hash
      expect(activity_streams.first[:type]).to be_a String
      expect(activity_streams.first[:data]).to be_a Array
    end
  end
end
