class HooksController < ApplicationController
  def strava
    challange = params['hub.challenge']

    render json: { 'hub.challenge':challange }
  end
end