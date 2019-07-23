# frozen_string_literal: true

class SongShowFacade
  def initialize(song, user)
    @song = song
    @user = user
  end

  def chart_data
    user_songs = UserSong.where(user: @user, song: @song)
    user_songs.each do |song|
      data[:labels] << song.played_at.strftime('%-d %B %Y')
      data[:datasets][0][:data] << (song.power_ranking * 100).round
    end
    data
  end

  def chart_options
    {
      width: 200,
      height: 200,
      legend: { display: false }
    }
  end

private

  def data
    {
      labels: [],
      datasets: [{
        label: 'PowerRanking',
        background_color: '#FF0000',
        border_color: '#FFD600',
        data: []
      }]
    }
  end
end
