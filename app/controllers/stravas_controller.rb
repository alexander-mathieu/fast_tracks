class StravasController < ApplicationController
  def create
    strava = StravaService.new(current_user.strava_token)
    save_activites(strava.get_user_activities)
    flash[:success] = "Strava data synced"
    redirect_to dashboard_path
  end

  private

  def save_activites(activities)
    activities = map_activies(activities)
    last_activity_id = current_user.last_activity_id
    activities.each do |activity|
      if (last_activity_id.nil? || activity[:strava_id] > last_activity_id)
        current_user.activities.create(activity)
      end
    end
  end

  def map_activies(activities)
    activities.each_with_object([]) do |activity, array|
      array << {
        :name => activity[:name],
        :distance => activity[:distance],
        :moving_time => activity[:moving_time],
        :elapsed_time => activity[:elapsed_time],
        :total_elevation_gain => activity[:total_elevation_gain],
        :activity_type => activity[:type],
        :strava_id => activity[:id],
        :start_date => activity[:start_date],
        :start_date_local => activity[:start_date_local],
        :start_latlng => activity[:start_latlng],
        :end_latlng => activity[:end_latlng],
        :average_speed => activity[:average_speed],
        :max_speed => activity[:max_speed],
        :pr_count => activity[:pr_count]
      }
    end
  end
end