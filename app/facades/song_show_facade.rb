class SongShowFacade
  def initialize(song, user)
    @song = song
    @user = user
  end

  def chart_data
    user_songs = UserSong.where(user: @user, song: @song)
    data = {
      labels: [],
      datasets: [{
        label: "PowerRanking",
        background_color: "#FF0000",
        border_color: "#FFD600",
        data: []
        }]
    }
    user_songs.each do |song|
      data[:labels] << DateTime.strptime(song.played_at.to_s, '%Q').strftime('%-d %B %Y')
      data[:datasets][0][:data] << song.power_ranking
    end
    data
  end

  def chart_options
    {
      width: 200,
      height: 200,
      legend: {display: false}
    }
  end
end
