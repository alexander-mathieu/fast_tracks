# frozen_string_literal: true

# This class builds song/user_song objects from a spotify API call
class SongSifter
  def initialize(songs_data, current_user)
    @songs_data = songs_data
    @user = current_user
  end

  def sift_songs
    @songs_data.each do |song_hash|
binding.pry
      attr_array = attr_grabber(song_hash)
      attrs = attr_hasher(attr_array)
      current_song = song_build(attrs)
      user_song_build(current_song.id, song_hash[:played_at])  
    end
  end

  def attr_grabber(song_hash)
    [song_hash[:played_at], song_hash[:track][:id],
     song_hash[:track][:name], song_hash[:track][:artists].first[:name],
     song_hash[:track][:album][:name], song_hash[:track][:href],
     song_hash[:track][:album][:images].first[:url],
     song_hash[:track][:duration_ms]]
  end

  def attr_hasher(attr_grab_arry)
    { played_at: attr_grab_arry[0], spotify_id: attr_grab_arry[1],
      title: attr_grab_arry[2], artist: attr_grab_arry[3],
      album: attr_grab_arry[4], album_art_url: attr_grab_arry[6],
      spotify_url: attr_grab_arry[5], length:  attr_grab_arry[7] }
  end

  def song_build(attrs)
    Song.find_or_create_by!(spotify_id: attrs[:spotify_id]) do |song|
      song.title = attrs[:title]
      song.artist = attrs[:artist]
      song.album = attrs[:album]
      song.album_art_url = attrs[:album_art_url]
      song.spotify_url = attrs[:spotify_url]
      song.length = attrs[:length]
    end
  end

  def user_song_build(song_id, played_at)
    UserSong.find_or_create_by!(played_at: played_at) do |user_song|
      user_song.user_id = @user.id
      user_song.song_id = song_id
    end
  end
end
