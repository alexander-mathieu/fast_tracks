# frozen_string_literal: true

class SongsController < ApplicationController
  def show
    @song = Song.find(params[:id])
    render locals: {
      facade: SongShowFacade.new(@song, current_user)
    }
  end
end
