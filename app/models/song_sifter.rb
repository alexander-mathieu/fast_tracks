class SongSifter
	def initialize(songs_data, current_user)
		@songs_data = songs_data
		@user = current_user
	end

	def sift_songs
		@songs_data.each do |song|
			played_at = song[:played_at]
			user_id = @user.strava_uid	
			spotify_id = song[:track][:id]
			title = song[:track][:name]
			artist = song[:track][:artists].first[:name]	
			album = song[:track][:album][:name]
			album_art_url = song[:track][:album][:images].first[:url]
			length = song[:track][:duration_ms]
			spotify_url = song[:track][:href]

			new_song = Song.find_or_create_by(spotify_id: spotify_id) do |song_hash|
				song_hash.title = title	
				song_hash.artist = artist	
				song_hash.album = album
				song_hash.album_art_url = album_art_url
				song_hash.spotify_url = spotify_url
				song_hash.length = length
			end

			UserSong.create!(user_id: @user.id, song_id: new_song.id, played_at: played_at)
		end
	end
end
