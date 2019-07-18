# frozen_string_literal: true

class LoginController < ApplicationController
  def create
    auth = request.env['omniauth.auth']
    token = auth['credentials']['token']
    user_info = StravaService.new(token).get_user_info
    create_user(user_info, token)

    redirect_to dashboard_path
  end

  private

  def create_user(user_info, token)
    user = User.find_or_create_by(strava_uid: user_info[:id])
    if user
      session[:user_id] = user.id
      user.update(strava_firstname: user_info[:firstname],
                  strava_lastname: user_info[:lastname],
                  strava_token: token)
    end
  end
end
