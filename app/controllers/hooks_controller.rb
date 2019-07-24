class HooksController < ApplicationController
  def strava
    challange = params['hub.challenge']
    puts request.body
    render json: { 'hub.challenge':challange }
  end
end