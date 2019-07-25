class HooksController < ApplicationController
  skip_before_action :verify_authenticity_token
  # protect_from_forgery with: :null_session
  def strava
    activity = JSON.parse(request.body.read, symbolize_names: true)

    if activity[:aspect_type] == 'create'
      create(activity)
    end

    challenge = params['hub.challenge']
    puts request.body
    render json: { 'hub.challenge':challenge }
  end

  private

  def create(activity)
    hook_data = activity[:hook]
    user = User.find_by(strava_uid: hook_data[:owner_id])
    strava = StravaService.new(user.strava_token)
    save_activity(strava.get_user_activity(hook_data[:object_id]), user)
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