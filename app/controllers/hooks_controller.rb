class HooksController < ApplicationController
  def strava
    challange = params['hub.challenge']
    puts params
    render json: { 'hub.challenge':challange }
  end
end