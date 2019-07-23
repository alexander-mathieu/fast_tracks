# frozen_string_literal: true

class StravaService
  def initialize(user_token)
    @user_token = user_token
  end

  def get_user_info
    get_json('athlete')
  end

  def get_user_activities
    get_json('activities')
  end

  def get_activity_streams(activity_id)
    params = { keys: 'time,grade_smooth,velocity_smooth' }
    get_json("activities/#{activity_id}/streams", params)
  end

  private

  def get_json(url, params = {})
    response = conn.get(url, params)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new('https://www.strava.com/api/v3/') do |f|
      f.params['access_token'] = @user_token
      f.adapter Faraday.default_adapter
    end
  end
end
