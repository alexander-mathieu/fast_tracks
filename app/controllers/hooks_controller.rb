class HooksController < ApplicationController
  def strava
    type = request.body['aspect_type']

    if type == 'create'
      create(request.body['hook'])
    end

    challenge = params['hub.challenge']
    # puts request.body
    render json: { 'hub.challenge':challenge }
  end

  private

  def create
    hook_data = request.body['hook']
    user = User.find_by(strava_uid: hook_data['owner_id'])
    strava = StravaService.new(user.strava_token)
    save_activity(strava.get_user_activity(hook_data['object_id']))
  end

  def save_activity(activities)
    activities = map_activities(activities)
    last_activity_id = current_user.last_activity_id
    activities.each do |activity|
      if (last_activity_id.nil? || activity[:strava_id] > last_activity_id)
        current_user.activities.create(activity)
      end
    end
  end

  def map_activities(activities)
    activities.each_with_object([]) do |activity, array|
      array << {
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
end