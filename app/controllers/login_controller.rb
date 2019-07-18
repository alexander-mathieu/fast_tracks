class LoginController < ApplicationController
  def new
    auth = request.env['omniauth.auth']
    token = auth['credentials']['token']
    temp = get_strava_info(token)
    redirect_to dashboard_path
  end

  private

  def get_strava_info(token)
    response = conn.get do |req|
      req.url 'https://www.strava.com/api/v3/athlete'
      req.params['access_token'] = token
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new
  end
end
