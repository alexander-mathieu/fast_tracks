# frozen_string_literal: true

class SongShowFacade
  def initialize(song, user)
    @song = song
    @user = user
  end

  def chart_data
    data_hash = data
    user_songs.each do |song|
      data_hash[:labels] << song.played_at.strftime('%-d %B %Y')
      data_hash[:datasets][0][:data] << (song.power_ranking * 100).round
    end
    data_hash
  end

  def chart_options
    {
      width: 200,
      height: 200,
      legend: { display: false }
    }
  end

  def average_power_ranking
    user_songs.average(:power_ranking)
  end

  def activity_count
    user_songs.count
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

  def user_songs
    @_user_songs = UserSong.where(user: @user, song: @song)
  end
end
