# frozen_string_literal: true

# Top Level Documentation
class HooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def strava
    activity = JSON.parse(request.body.read, symbolize_names: true)

    if activity[:aspect_type] == 'create'
      create(activity)
    end

    challenge = params['hub.challenge']
    render json: { 'hub.challenge': challenge }
  end

  private

  def create(activity)
    user = User.find_by(strava_uid: activity[:owner_id])
    strava = StravaService.new(user.strava_token)
    spotify = SpotifyService.new(user.spotify_token)
    if save_activity(strava.get_user_activity(activity[:object_id]), user)
      response = strava.get_activity_streams(activity[:object_id])
      stream_data = stream_hash(response)
      songs = spotify.get_user_songs[:items]
      SongSifter.new(songs, user).sift_songs
    end
  end

  def stream_hash(response)
    smashed_hash = {}
    i = 0
    response[3][:data].map do |time|
      smashed_hash[time] = {}
      smashed_hash[time][response[0][:type]] = response[0][:data][i]
      smashed_hash[time][response[1][:type]] = response[1][:data][i]
      smashed_hash[time][response[2][:type]] = response[2][:data][i]
      i += 1
    end
  end

  def save_activity(activity, user)
    activity = map_activity(activity)
    user.activities.create(activity)
  end

  def map_activity(activity)
    {
      name: activity[:name],
      distance: activity[:distance],
      moving_time: activity[:moving_time],
      elapsed_time: activity[:elapsed_time],
      total_elevation_gain: activity[:total_elevation_gain],
      activity_type: activity[:type],
      strava_id: activity[:id],
      start_date: activity[:start_date],
      start_date_local: activity[:start_date_local],
      start_latlng: activity[:start_latlng],
      end_latlng: activity[:end_latlng],
      average_speed: activity[:average_speed],
      max_speed: activity[:max_speed],
      pr_count: activity[:pr_count]
    }
  end
end
